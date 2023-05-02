import Combine
import Foundation

public protocol Stepper {
    var steps: PassthroughSubject<any Step, Never> { get }
    var initialStep: any Step { get }
}

public extension Stepper {
    var initialStep: any Step {
        NoneStep()
    }
}

public final class OneStepper: Stepper {
    public let steps: PassthroughSubject<any Step, Never> = .init()
    private let singleStep: any Step

    init(singleStep: any Step) {
        self.singleStep = singleStep
    }

    public var initialStep: Step {
        singleStep
    }
}

public final class DefaultStepper: Stepper {
    public let steps: PassthroughSubject<Step, Never> = .init()

    public init() {}
}
