import UIKit

protocol HomeRoutingLogic: AnyObject {
    func routeToSpotlight(spotlight: Spotlight)
    func routeToCash(cash: Cash)
    func routeToProduct(product: Product)
}

class HomeRouter: NSObject, HomeRoutingLogic {
    weak var viewController: HomeViewController?

    // MARK: Routing
    func routeToSpotlight(spotlight: Spotlight) {
        // Sera implementado em outro momento
    }

    func routeToCash(cash: Cash) {
        // Sera implementado em outro momento
    }

    func routeToProduct(product: Product) {
        let controller = DetailFactory.create(product: product)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
