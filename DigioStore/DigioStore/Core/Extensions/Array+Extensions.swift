import UIKit

extension Array where Element == NSLayoutConstraint {

    func activate() {
        forEach {
            $0.isActive = true
        }
    }
}
