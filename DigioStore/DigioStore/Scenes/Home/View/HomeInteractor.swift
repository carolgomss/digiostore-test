import UIKit

protocol HomeBusinessLogic {
    func loadHome()
}

class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?

    func loadHome() {
        presenter?.loadData()
        worker?.loadHome(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter?.presentData(data: response)
            case .failure(let error):
                self?.presenter?.presentError(error: error)
            }
        })
    }
}
