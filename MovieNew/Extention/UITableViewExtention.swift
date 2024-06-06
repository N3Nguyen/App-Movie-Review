import Foundation
import UIKit

public extension UIViewController {
    class func loadFromNib<T: UIViewController>(type: T.Type) -> T {
        return T(nibName: String(describing: T.self), bundle: nil)
    }
    
    class func initFromStoryboard<T: UIViewController>(feature: AppScreen, identify: String? = nil) -> T {
        let viewControllerIdentify = identify ?? String(describing: T.self)
        return UIStoryboard.init(name: feature.storyBoardName, bundle: nil)
            .instantiateViewController(withIdentifier: viewControllerIdentify) as! T
    }
}
