import UIKit

public protocol Flow: Presentable {
    var root: Presentable { get }

    func navigate(to step: any Step) -> FlowContributors
}
