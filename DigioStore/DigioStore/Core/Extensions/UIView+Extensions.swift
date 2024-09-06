import UIKit

enum DSCornerRadius: CGFloat {
    case small = 8
    case big = 12
    case biggest = 24
}

extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    func setCornerRadius(_ radius: DSCornerRadius) {
        layer.cornerRadius = radius.rawValue
        layer.masksToBounds = true
    }
}
