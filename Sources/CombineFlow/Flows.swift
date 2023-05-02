import UIKit

public enum Flows {
    public static func use<Root>(
        _ flow: any Flow,
        block: @escaping (_ root: Root) -> Void
    ) where Root: UIViewController {
        guard let root = flow.root as? Root else {
            fatalError("The Root type does not match moordinator's root")
        }
        block(root)
    }
}
