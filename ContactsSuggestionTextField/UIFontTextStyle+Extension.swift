
import Foundation

/// returns the text style depending on device type.
extension UIFont.TextStyle {
    static var styleForDevice: UIFont.TextStyle {
        return UIDevice().userInterfaceIdiom == .phone ? .footnote : .body
    }
}
