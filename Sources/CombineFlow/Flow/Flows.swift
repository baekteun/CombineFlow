import UIKit

public enum Flows {
    public static func use<Root>(
        _ flow: any Flow,
        block: @escaping (_ root: Root) -> Void
    ) where Root: UIViewController {
        guard let root = flow.root as? Root else {
            fatalError("The Root type does not match Flow's root")
        }
        block(root)
    }

    public static func use<Root1, Root2>(
        _ Flow1: any Flow,
        _ Flow2: any Flow,
        block: @escaping (_ root1: Root1, _ root2: Root2) -> Void
    ) where Root1: UIViewController, Root2: UIViewController {
        guard
            let root1 = Flow1.root as? Root1,
            let root2 = Flow2.root as? Root2
        else {
            fatalError("The Root type does not match Flow's root")
        }
        block(root1, root2)
    }

    public static func use<Root1, Root2, Root3>(
        _ Flow1: any Flow,
        _ Flow2: any Flow,
        _ Flow3: any Flow,
        block: @escaping (_ root1: Root1, _ root2: Root2, _ root3: Root3) -> Void
    ) where Root1: UIViewController, Root2: UIViewController, Root3: UIViewController {
        guard
            let root1 = Flow1.root as? Root1,
            let root2 = Flow2.root as? Root2,
            let root3 = Flow3.root as? Root3
        else {
            fatalError("The Root type does not match Flow's root")
        }
        block(root1, root2, root3)
    }

    public static func use<Root1, Root2, Root3, Root4>(
        _ Flow1: any Flow,
        _ Flow2: any Flow,
        _ Flow3: any Flow,
        _ Flow4: any Flow,
        block: @escaping (_ root1: Root1, _ root2: Root2, _ root3: Root3, _ root4: Root4) -> Void
    )
    where
        Root1: UIViewController,
        Root2: UIViewController,
        Root3: UIViewController,
        Root4: UIViewController {
        guard
            let root1 = Flow1.root as? Root1,
            let root2 = Flow2.root as? Root2,
            let root3 = Flow3.root as? Root3,
            let root4 = Flow4.root as? Root4
        else {
            fatalError("The Root type does not match Flow's root")
        }
        block(root1, root2, root3, root4)
    }

    public static func use<Root1, Root2, Root3, Root4, Root5>(
        _ Flow1: any Flow,
        _ Flow2: any Flow,
        _ Flow3: any Flow,
        _ Flow4: any Flow,
        _ Flow5: any Flow,
        block: @escaping (_ root1: Root1, _ root2: Root2, _ root3: Root3, _ root4: Root4, _ root5: Root5) -> Void
    ) where Root1: UIViewController,
            Root2: UIViewController,
            Root3: UIViewController,
            Root4: UIViewController,
            Root5: UIViewController {
        guard
            let root1 = Flow1.root as? Root1,
            let root2 = Flow2.root as? Root2,
            let root3 = Flow3.root as? Root3,
            let root4 = Flow4.root as? Root4,
            let root5 = Flow5.root as? Root5
        else {
            fatalError("The Root type does not match Flow's root")
        }
        block(root1, root2, root3, root4, root5)
    }

    public static func use(
        _ Flows: [some Flow],
        block: @escaping (_ roots: [UIViewController]) -> Void
    ) {
        let roots = Flows
            .compactMap { $0.root as? UIViewController }
        block(roots)
    }
}
