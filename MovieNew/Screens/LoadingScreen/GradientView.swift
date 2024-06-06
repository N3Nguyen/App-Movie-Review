import Foundation
import UIKit

class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    private func setupGradient() {
        guard let gradientLayer = layer as? CAGradientLayer else {
            return
        }
        
        let colors: [CGColor] = [ #colorLiteral(red: 1, green: 0.7196786404, blue: 0.583871305, alpha: 1), #colorLiteral(red: 0.9956462979, green: 0.910874784, blue: 0.8237903714, alpha: 1), #colorLiteral(red: 0.9850923419, green: 0.960513413, blue: 0.9782195687, alpha: 1), #colorLiteral(red: 0.4992206693, green: 0.8224374056, blue: 0.9060878158, alpha: 1)]
        
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradientLayer.locations = [0.0, 0.5, 1.0]
    }
}
