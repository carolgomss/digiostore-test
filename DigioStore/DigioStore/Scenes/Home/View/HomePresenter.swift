import UIKit

protocol HomePresentationLogic: AnyObject {
    func loadData()
    func presentData(data: HomeResponse)
    func presentError(error: DigioError)
}

class HomePresenter: HomePresentationLogic {
    typealias ViewController = (HomeDisplayLogic & LoadingPresenting & ErrorPresenting)

    weak var viewController: ViewController?
    weak var worker: HomeWorker?

    func loadData() {
        viewController?.showLoading()
    }

    func presentData(data: HomeResponse) {
        viewController?.hideLoading()
        viewController?.displaySpotlight(data.spotlight)
        viewController?.displayProducts(data.products)
        viewController?.displayCash(data.cash)
    }

    func presentError(error: DigioError) {
        viewController?.hideLoading()
        viewController?.displayError(error)
    }
}
