import UIKit

var associateObjectValue: Int = 0

// MARK: - UIView Extension
public extension UIView {
    fileprivate var isAnimate: Bool {
        get {
            objc_getAssociatedObject(self, &associateObjectValue) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &associateObjectValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @IBInspectable var shimmerAnimation: Bool {
        get {
            isAnimate
        }
        set {
            self.isAnimate = newValue
        }
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
    
    func stopShimmeringAnimation() {
        for animateView in subViewForAnimate() {
            let gradientView = createGradientView(from: animateView)
            gradientView.superview?.isHidden = true
            gradientView.layer.removeAnimation(forKey: "shimmer")
            gradientView.layer.mask = nil
        }
    }
    
    func subViewForAnimate() -> [UIView] {
        var obj: [UIView] = []
        for objView in self.subviewsRecursive() {
            obj.append(objView)
        }
        return obj.filter({ (obj) -> Bool in
            obj.shimmerAnimation
        })
    }
    
    func startShimmeringAnimation() {
        let gradientView = createGradientView(from: self)
        gradientView.superview?.isHidden = false
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.7, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
        gradientLayer.frame = self.bounds
        gradientView.layer.mask = gradientLayer
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 0.7
        animation.fromValue = -self.frame.size.width
        animation.toValue = self.frame.size.width
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        CATransaction.setCompletionBlock { [weak self] in
              guard let strongSelf = self else { return }
              strongSelf.layer.mask = nil
            }
        gradientLayer.add(animation, forKey: "shimmer")
        CATransaction.commit()
    }
    
    func createGradientView(from view: UIView) -> UIView {
        if let gradientView = view.viewWithTag(9_999_999) {
            return gradientView
        } else {
            let gradientBackgroundView = UIView(frame: view.bounds)
            gradientBackgroundView.backgroundColor = ColorDefine.color1E1E1E
            gradientBackgroundView.clipsToBounds = true
            gradientBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(gradientBackgroundView)
            
            let gradientView = UIView(frame: gradientBackgroundView.bounds)
            gradientView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            gradientView.tag = 9_999_999
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
    
    func addGradientToView(view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        let transparentColor = UIColor.clear.cgColor
        let blackColor = ColorDefine.color000000.cgColor
        
        gradientLayer.colors = [transparentColor, blackColor]
        gradientLayer.locations = [0.0, 0.5]
        
        let startPoint = CGPoint(x: 0.5, y: 0.0)
        let endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addHalfGradientToView(view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        let transparentColor = UIColor.clear.cgColor
        let blackColor = ColorDefine.color000000.withAlphaComponent(0.8).cgColor
        
        gradientLayer.colors = [transparentColor, blackColor]
        gradientLayer.locations = [0.0, 0.5]
        
        let startPoint = CGPoint(x: 0.5, y: 0.0)
        let endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientTopToBotView(view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        let topColor = ColorDefine.color000000.withAlphaComponent(0.6).cgColor
        let midColor = UIColor.clear.cgColor
        let botColor = ColorDefine.color000000.withAlphaComponent(0.6).cgColor
        
        gradientLayer.colors = [topColor, midColor, botColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        
        let startPoint = CGPoint(x: 0.5, y: 0.0)
        let endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func shouldAddMoreText(to label: UILabel) -> Bool {
        guard let labelText = label.text else {
            return false
        }
        
        let labelSize = CGSize(width: UIScreen.main.bounds.width - 32, height: .greatestFiniteMagnitude)
        let boundingBox = labelText.boundingRect(with: labelSize,
                                                 options: .usesLineFragmentOrigin,
                                                 attributes: [.font: AppConstants.FontQuickSans.demiBold.fontSize(12)],
                                                 context: nil)
        return boundingBox.size.width >= labelSize.width - 32
    }
    
    func addMoreText(to label: UILabel) {
        guard let labelText = label.text else {
            return
        }
        
        let moreText = " ...more"
        let fullText = labelText + moreText
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font:AppConstants.FontQuickSans.demiBold.fontSize(12)
        ]
        let attributedString = NSAttributedString(string: labelText, attributes: attributes)
        
        let labelWidth = label.bounds.width
        let textWidth = attributedString.size().width
        
        if textWidth > labelWidth {
            var index = labelText.count - 1
            while index > 0 {
                let substring = labelText.prefix(index)
                let substringText = String(substring) + moreText
                let substringAttributedString = NSAttributedString(string: substringText, attributes: attributes)
                let substringWidth = substringAttributedString.size().width
                if substringWidth <= labelWidth {
                    label.attributedText = substringAttributedString
                    return
                }
                index -= 1
            }
        }
        
        label.attributedText = attributedString
    }
}

extension DispatchQueue {
    // This method will dispatch the `block` to self.
    // If `self` is the main queue, and current thread is main thread, the block
    // will be invoked immediately instead of being dispatched.
    func safeAsync(_ block: @escaping ()->()) {
        if self === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async { block() }
        }
    }
}
