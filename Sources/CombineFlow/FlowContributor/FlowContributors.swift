import UIKit

public enum FlowContributors {
    case one(flowContributor: FlowContributor)
    case multiple(flowContributors: [FlowContributor])
    case end(forwardToParentFlowWithStep: any Step)
    case none
}
