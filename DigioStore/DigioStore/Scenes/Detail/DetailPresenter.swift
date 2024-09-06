import UIKit

protocol DetailPresentationLogic: AnyObject {
  func presentProduct(_ product: Product)
}

class DetailPresenter: DetailPresentationLogic {
    weak var viewController: DetailDisplayLogic?

    func presentProduct(_ product: Product) {
        viewController?.displayProduct(product)
    }
}
