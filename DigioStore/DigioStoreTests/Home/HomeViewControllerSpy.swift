@testable import DigioStore

enum HomeViewControllerEvents {
    case displayProducts
    case displaySpotlight
    case displayCash
    case showLoading
    case hideLoading
    case showError
}

class HomeViewControllerSpy: HomeDisplayLogic {

    var events: [HomeViewControllerEvents] = []

    func displayProducts(_ products: [Product]) {
        events.append(.displayProducts)
    }

    func displaySpotlight(_ spotlight: [Spotlight]) {
        events.append(.displaySpotlight)
    }

    func displayCash(_ cash: Cash) {
        events.append(.displayCash)
    }
}

extension HomeViewControllerSpy: LoadingPresenting {
    func showLoading() {
        events.append(.showLoading)
    }

    func hideLoading() {
        events.append(.hideLoading)
    }
}

extension HomeViewControllerSpy: ErrorPresenting {
    func displayError(_ error: DigioStore.DigioError) {
        events.append(.showError)
    }
}
