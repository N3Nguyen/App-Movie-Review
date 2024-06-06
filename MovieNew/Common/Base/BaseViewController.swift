import UIKit

open class BaseViewController: UIViewController {
    
    @IBOutlet public weak var topConstraint: NSLayoutConstraint?
    
    // MARK: New Config for new elements
    //
    
    public var viewActivityIndicator: UIView?
    public let indicatorSize: CGFloat = 30
    public var gradientLoadingTag = 9_999_999
    public var shimmerAnimationKey = "shimmer"
    public var colorShimmer = ColorDefine.color1E1E1E
    public var isNeededReloadData: Bool = false

    open var timer: Timer?
    public var didGetData: Bool = false {
        didSet {
            if didGetData {
                isStartAnimation(isStart: false)
            }
        }
    }
    public var headerViewHeight: CGFloat = 44
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Alert

public extension BaseViewController {
    // MARK: Alert Actionsheet
//    func showMessageAlert(title: String,
//                          textError: String? = nil,
//                          action: (() -> Void)? = nil) {
//        let popup = UIViewController.loadFromNib(type: PopupCommonViewController.self)
//        popup.modalPresentationStyle = .overFullScreen
//        popup.modalTransitionStyle = .crossDissolve
//        popup.centerTitle = title
//        popup.message = "Something went wrong"
//        popup.doneAction = action
//        self.present(popup, animated: true, completion: nil)
//    }

}

// MARK: - Activity Indicator
public extension BaseViewController {
    func customHeaderViewHeight(value: CGFloat) {
        headerViewHeight = value
    }
    
    func displayActivityIndicatorView(display: Bool) {
        if viewActivityIndicator == nil {
            self.setupActivityIndicator()
        }
        DispatchQueue.main.async { // Make sure you're on the main thread here
            self.viewActivityIndicator?.isHidden = !display
       }
      
        if !display {
            viewActivityIndicator?.removeFromSuperview()
            viewActivityIndicator = nil
        } else {
            
        }
    }
    
    private func setupActivityIndicator() {
        let bounds: CGRect = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y
                                    + CGFloat(Contants.heightStatus + headerViewHeight),
                                    width: view.frame.width,
                                    height: view.frame.height)
        viewActivityIndicator = UIView(frame: bounds)
        viewActivityIndicator?.backgroundColor = ColorDefine.color000000.withAlphaComponent(0)
        view.addSubview(viewActivityIndicator!)
        // Constraint - Top
        view.addConstraint(NSLayoutConstraint(item: viewActivityIndicator!,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: self.topLayoutGuide,
                                              attribute: .bottom,
                                              multiplier: 1,
                                              constant: topConstraint?.constant ?? 0))
        
        // Constraint - Right
        view.addConstraint(NSLayoutConstraint(item: viewActivityIndicator!,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .trailing,
                                              multiplier: 1,
                                              constant: 0))
        // Constraint - Left
        view.addConstraint(NSLayoutConstraint(item: viewActivityIndicator!,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .leading,
                                              multiplier: 1,
                                              constant: 0))
        
        // Constraint - Bottom
        view.addConstraint(NSLayoutConstraint(item: viewActivityIndicator!,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: bottomLayoutGuide,
                                              attribute: .bottom,
                                              multiplier: 1,
                                              constant: 0))
        
        let activityIndicatorView = RefreshLoadingView(frame: CGRect(x: 0, y: 0, width: indicatorSize, height: indicatorSize))
        activityIndicatorView.center = CGPoint(x: bounds.size.width / 2,
                                               y: (bounds.size.height / 2) - (CGFloat(Contants.heightStatus + headerViewHeight)))
        activityIndicatorView.backgroundColor = .clear
        activityIndicatorView.startAnimation()
        viewActivityIndicator?.addSubview(activityIndicatorView)
    }
}

// MARK: - Animation Related
extension BaseViewController {
    public func isStartAnimation(isStart: Bool, targetTag: Int? = nil) {
        if isStart {
            startAnimation(targetTag: targetTag)
        } else {
            stopAnimation(targetTag: targetTag)
        }
    }
    
    @objc
    open func startAnimation() {
        startAnimation(targetTag: nil)
    }
    
    func startAnimation(targetTag: Int? = nil) {
        let arrAnimate = getSubViewsForAnimate(targetTag: targetTag)
        for animateView in arrAnimate {
            let gradientView = getGradientView(from: animateView)
            gradientView.superview?.isHidden = false
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.7, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
            gradientLayer.frame = animateView.bounds
            gradientView.layer.mask = gradientLayer
            
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 0.7
            animation.fromValue = -animateView.frame.size.width
            animation.toValue = animateView.frame.size.width
            animation.repeatCount = .infinity
            animation.isRemovedOnCompletion = false
            
            gradientLayer.add(animation, forKey: shimmerAnimationKey)
        }
    }
    
    public func stopAnimation(targetTag: Int? = nil) {
        for animateView in getSubViewsForAnimate(targetTag: targetTag) {
            let gradientView = getGradientView(from: animateView)
            gradientView.superview?.isHidden = true
            gradientView.layer.removeAnimation(forKey: shimmerAnimationKey)
            gradientView.layer.mask = nil
        }
    }
    
    public func getSubViewsForAnimate(targetTag: Int? = nil) -> [UIView] {
        var obj: [UIView] = []
        for objView in view.subviewsRecursive() {
            obj.append(objView)
        }
        return obj.filter({ (obj) -> Bool in
            let targetTag = targetTag == nil ? true : obj.tag == targetTag ?? 0
            return obj.shimmerAnimation && targetTag
        })
    }
    
    @objc
    open func getGradientView(from view: UIView) -> UIView {
        if let gradientView = view.viewWithTag(gradientLoadingTag) {
            return gradientView
        } else {
            let gradientBackgroundView = UIView(frame: view.bounds)
            gradientBackgroundView.backgroundColor = colorShimmer
            gradientBackgroundView.clipsToBounds = true
            gradientBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(gradientBackgroundView)
            
            let gradientView = UIView(frame: gradientBackgroundView.bounds)
            gradientView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            gradientView.tag = gradientLoadingTag
            gradientView.translatesAutoresizingMaskIntoConstraints = false
            gradientBackgroundView.addSubview(gradientView)
            
            gradientBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            gradientBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            gradientBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            gradientBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
            gradientView.topAnchor.constraint(equalTo: gradientBackgroundView.topAnchor).isActive = true
            gradientView.bottomAnchor.constraint(equalTo: gradientBackgroundView.bottomAnchor).isActive = true
            gradientView.leadingAnchor.constraint(equalTo: gradientBackgroundView.leadingAnchor).isActive = true
            gradientView.trailingAnchor.constraint(equalTo: gradientBackgroundView.trailingAnchor).isActive = true
            
            view.layoutIfNeeded()
            
            return gradientView
        }
    }
    
    public func animateTabBar(hidden: Bool) {
        guard let tabBar = tabBarController?.tabBar else { return }
        let duration = 0.3
        if hidden {
            UIView.animate(withDuration: duration) {
            }
            tabBar.frame.origin.y = self.view.bounds.height + 88
        } else {
            UIView.animate(withDuration: duration) {
               
            }
            tabBar.frame.origin.y = self.view.bounds.height - tabBar.bounds.height - 30
        }
    }
    
}
