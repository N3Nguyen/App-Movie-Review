import Foundation
import UIKit

struct AppConstants {
    // String constant
    static let empty = ""
    // App UI config layout
    static let margin: CGFloat = 16.0
    static let layoutRatio: CGFloat = UIScreen.main.bounds.width / 428.0
    
    // Image type
    enum ImageType {
        
        enum BackdropWidth: String {
            case w300
            case w780
            case w1280
            case original
        }
        
        enum PosterWidth: String {
            case w92
            case w154
            case w185
            case w342
            case w500
            case w780
            case original
        }
    }
    
    // App icons
    enum Image: String {
        case top32 = "top32"
        case back32 = "back32"
        case imgPlaceholder = "img_placeholder"
        case imgDropbakPlaceholder = "dropback_placeholder"
        case backdropBlurBot = "backdrop_blur_bottom"
        func toUIImage() -> UIImage {
            return UIImage(named: self.rawValue) ?? UIImage()
        }
    }
    
    // App fonts
    enum FontQuickSans: String {
        case heavy = "Quicksand-Heavy"
        case bold = "Quicksand-Bold"
        case demiBold = "Quicksand-DemiBold"
        case medium = "Quicksand-Medium"
        case regular = "Quicksand-Regular"
        func fontSize(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}
