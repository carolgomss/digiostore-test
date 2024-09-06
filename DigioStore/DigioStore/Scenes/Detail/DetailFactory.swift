class DetailFactory {
    static func create(product: Product) -> DetailViewController {
        let viewController = DetailViewController()
        let interactor = DetailInteractor(product: product)
        let presenter = DetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
}
