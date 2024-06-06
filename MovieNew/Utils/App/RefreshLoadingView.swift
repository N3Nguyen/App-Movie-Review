import UIKit

public class RefreshLoadingView: UIView {
    
    private var loaderLayer = CAShapeLayer()
    
    public let strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
        
        let group = CAAnimationGroup()
        group.duration = 1.2
        group.isRemovedOnCompletion = false
        group.repeatCount = .infinity
        group.animations = [animation]
        
        return group
    }()
    
    public let strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.2
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
        
        let group = CAAnimationGroup()
        group.duration = 1.2
        group.isRemovedOnCompletion = false
        group.repeatCount = .infinity
        group.animations = [animation]
        
        return group
    }()
    
    public let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi * 2
        animation.duration = 2
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        return animation
    }()
    
    public let colorAnimation: CAAnimation = {
        let animColor1 = CABasicAnimation(keyPath: "strokeColor")
        animColor1.fromValue = ColorDefine.colorBlue.cgColor
        animColor1.toValue = ColorDefine.colorOrange.cgColor
        animColor1.duration = 0.3
        
        let animColor2 = CABasicAnimation(keyPath: "strokeColor")
        animColor2.fromValue = ColorDefine.colorOrange.cgColor
        animColor2.toValue = ColorDefine.colorGreen.cgColor
        animColor2.beginTime = 0.3
        animColor2.duration = 0.3
        
        let animColor3 = CABasicAnimation(keyPath: "strokeColor")
        animColor3.fromValue = ColorDefine.colorGreen.cgColor
        animColor3.toValue = ColorDefine.colorBlue.cgColor
        animColor3.beginTime = 0.6
        animColor3.duration = 0.3
        
        let group = CAAnimationGroup()
        group.duration = 0.9
        group.repeatCount = .infinity
        group.isRemovedOnCompletion = false
        group.animations = [animColor1, animColor2, animColor3]
        
        return group
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initLoadingView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initLoadingView()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        initLoadingView()
    }
    
    public override func draw(_ rect: CGRect) {
    }
    
    private func initLoadingView() {
        backgroundColor = .clear
        let loaderPath = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2,
                                                         y: bounds.size.height / 2),
                                      radius: bounds.size.width / 2, startAngle: -CGFloat.pi / 2,
                                      endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        loaderLayer.path = loaderPath.cgPath
        loaderLayer.frame = bounds
        loaderLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        loaderLayer.lineWidth = 2
        loaderLayer.lineCap = .round
        loaderLayer.strokeColor = UIColor.blue.cgColor
        loaderLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(loaderLayer)
    }
    
    public func removeAnimation() {
        loaderLayer.removeAllAnimations()
    }
    
    public func startAnimation() {
        loaderLayer.add(strokeEndAnimation, forKey: "strokeEnd")
        loaderLayer.add(strokeStartAnimation, forKey: "strokeStart")
        loaderLayer.add(rotationAnimation, forKey: "rotation")
        loaderLayer.add(colorAnimation, forKey: "color")
    }
}
