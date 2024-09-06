import UIKit

extension UIColor {
    public static var primary: UIColor {
        .init(red: 0.07, green: 0.10, blue: 0.16, alpha: 1.00)
    }

    public static var secondary: UIColor {
        .init(red: 0.43, green: 0.43, blue: 0.43, alpha: 1.00)
    }
}

extension UIFont {
    public static func primary(ofSize: CGFloat) -> UIFont {
        .systemFont(ofSize: ofSize, weight: .semibold)
    }

    public static func secondary(ofSize: CGFloat) -> UIFont {
        .systemFont(ofSize: ofSize, weight: .semibold)
    }
}
