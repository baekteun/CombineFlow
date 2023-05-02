import Combine
import Foundation

public final class FlowCoordinator {
    private let id = UUID().uuidString
    private var bag = Set<AnyCancellable>()
    private weak var parentFlowCoordinator: FlowCoordinator?
    private var childFlowCoordinators: [String: FlowCoordinator] = [:]
    private let stepsSubject = PassthroughSubject<any Step, Never>()

    public func coordinate(
        flow: any Flow,
        with stepper: any Stepper = DefaultStepper()
    ) {
        stepsSubject
            .append(Publishers.Merge(stepper.steps, stepsSubject))
            .receive(on: RunLoop.main)
            .map { flow.navigate(to: $0) }
            .handleEvents(receiveOutput: { [weak self] contributors in
                switch contributors {
                case .none:
                    return

                case let .one(contributor):
                    self?.performSideEffect(contributor: contributor)

                case let .multiple(contributors):
                    contributors.forEach { self?.performSideEffect(contributor: $0) }

                case let .end(path):
                    self?.parentFlowCoordinator?.stepsSubject.send(path)
                    self?.childFlowCoordinators.removeAll()
                    self?.parentFlowCoordinator?
                        .childFlowCoordinators
                        .removeValue(forKey: self?.id ?? "")
                }
            })
            .map { [weak self] in self?.nextSteppers(from: $0) ?? [] }
            .flatMap { $0.publisher.eraseToAnyPublisher() }
            .flatMap { [weak self] in self?.toSteps(from: $0) ?? Empty().eraseToAnyPublisher() }
            .sink { [weak self] step in
                self?.stepsSubject.send(step)
            }
            .store(in: &bag)

        stepper.steps
            .sink { [weak self] step in
                self?.stepsSubject.send(step)
            }
            .store(in: &bag)

        Just(stepper.initialStep)
            .sink { [weak self] step in
                self?.stepsSubject.send(step)
            }
            .store(in: &bag)
    }
}

private extension FlowCoordinator {
    private func performSideEffect(contributor: FlowContributor) {
        switch contributor {
        case let .contribute(presentable, router):
            guard let childMoordinator = presentable as? Flow else { return }
            let flowCoordinator = FlowCoordinator()
            flowCoordinator.parentFlowCoordinator = self
            self.childFlowCoordinators[flowCoordinator.id] = flowCoordinator
            flowCoordinator.coordinate(flow: childMoordinator, with: router)
            
        case let .forwardToCurrentFlow(step):
            self.stepsSubject.send(step)
            
        case let .forwardToParentFlow(step):
            self.parentFlowCoordinator?.stepsSubject.send(step)
        }
    }

    private func nextSteppers(from contributors: FlowContributors) -> [any Stepper] {
        switch contributors {
        case let .one(.contribute(_, stepper)):
            return [stepper]

        case let .multiple(flowContributors):
            return flowContributors.compactMap {
                if case let .contribute(_, stepper) = $0 {
                    return stepper
                }
                return nil
            }

        default:
            return []
        }
    }

    private func toSteps(from stepper: any Stepper) -> AnyPublisher<any Step, Never> {
        stepper.steps
            .filter { !($0 is NoneStep) }
            .eraseToAnyPublisher()
    }
}
