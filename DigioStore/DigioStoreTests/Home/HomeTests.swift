import XCTest
@testable import DigioStore

final class DigioStoreTests: XCTestCase {

    func testShouldDisplayHomeWithSuccess() {
        // Given
        let (viewController, interactor) = sut(file: "home_products_success")

        // When
        interactor.loadHome()

        let expected: [HomeViewControllerEvents] = [
            .showLoading,
            .hideLoading,
            .displaySpotlight,
            .displayProducts,
            .displayCash
        ]

        // Then
        XCTAssert(viewController.events == expected, "Should display home")
    }

    func testShouldDisplayHomeWithError() {
        // Given
        let (viewController, interactor) = sut(file: "home_products_error")

        // When
        interactor.loadHome()

        let expected: [HomeViewControllerEvents] = [
            .showLoading,
            .hideLoading,
            .showError
        ]

        // Then
        XCTAssert(viewController.events == expected, "Should display error")
    }

    private func sut(file: String) -> (HomeViewControllerSpy, HomeInteractor) {
        let viewController = HomeViewControllerSpy()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let worker = HomeWorker(service: DigioServiceMock(file: file))
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        return (viewController, interactor)
    }
}
