import Foundation

public enum FlowContributor {
    case contribute(
        withNextPresentable: any Presentable,
        withNextRouter: any Stepper = DefaultStepper()
    )
    case forwardToCurrentFlow(withStep: any Step)
    case forwardToParentFlow(withStep: any Step)
}
