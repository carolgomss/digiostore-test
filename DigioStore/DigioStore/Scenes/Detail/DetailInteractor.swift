import UIKit

protocol DetailBusinessLogic {
    func loadData()
}

class DetailInteractor: DetailBusinessLogic {
    private let product: Product

    var presenter: DetailPresentationLogic?

    init(product: Product) {
        self.product = product
    }

    func loadData() {
        presenter?.presentProduct(product)
    }
}
