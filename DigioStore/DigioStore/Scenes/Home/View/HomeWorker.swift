import UIKit

class HomeWorker {

    fileprivate enum Paths { }

    private var service: DigioServiceProtocol

    init(service: DigioServiceProtocol = DigioService()) {
        self.service = service
    }

    func loadHome(completion: @escaping (Result<HomeResponse, DigioError>) -> Void) {
        service.get(path: HomeWorker.Paths.products, completion: completion)
    }
}

extension HomeWorker.Paths {
    static let products = "/products"
}
