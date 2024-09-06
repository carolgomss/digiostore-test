import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayProducts(_ products: [Product])
    func displaySpotlight(_ spotlight: [Spotlight])
    func displayCash(_ cash: Cash)
}

class HomeViewController: UIViewController {
    var interactor: HomeBusinessLogic?
    var router: HomeRoutingLogic?

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        UIScrollView()
    }()

    private lazy var headerView: DSHeaderView = {
        DSHeaderView()
    }()

    private lazy var loadingView: LoadingView = {
        LoadingView()
    }()

    private lazy var homeSpotlightView: HomeSpotlightView = {
        let view = HomeSpotlightView()
        view.delegate = self
        return view
    }()

    private lazy var homeCashView: HomeCashView = {
        let view = HomeCashView()
        view.delegate = self
        return view
    }()

    private lazy var homeProductView: HomeProductView = {
        let view = HomeProductView()
        view.delegate = self
        return view
    }()

    // MARK: Object lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        nil
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.loadHome()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension HomeViewController: ViewConfiguration {
    func setupViews() {
        view.addSubviews(loadingView, scrollView, stackView)
        stackView.addArrangedSubviews(headerView,
                                      homeSpotlightView,
                                      homeCashView,
                                      homeProductView)
    }

    func setupConstraints() {
        [
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ].activate()
        [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ].activate()
        [
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ].activate()
    }

    func setupAdditionals() {
        view.backgroundColor = .white
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displayProducts(_ products: [Product]) {
        homeProductView.load(products: products)
    }

    func displaySpotlight(_ spotlight: [Spotlight]) {
        homeSpotlightView.load(spotlight: spotlight)
    }

    func displayCash(_ cash: Cash) {
        homeCashView.load(cash: cash)
    }
}

extension HomeViewController: HomeSpotlightViewDelegate {
    func didSelectSpotlight(_ spotlight: Spotlight) {
        router?.routeToSpotlight(spotlight: spotlight)
    }
}

extension HomeViewController: HomeProductViewDelegate {
    func didSelectProduct(_ product: Product) {
        router?.routeToProduct(product: product)
    }
}

extension HomeViewController: HomeCashViewDelegate {
    func didSelectCash(_ cash: Cash) {
        router?.routeToCash(cash: cash)
    }
}

extension HomeViewController: ErrorPresenting {
    func displayError(_ error: DigioError) {
        let alertController = UIAlertController(title: error.message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tentar novamente",
                                   style: .default,
                                   handler: { [weak self] _ in
            self?.interactor?.loadHome()
        })
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

extension HomeViewController: LoadingPresenting {
    func showLoading() {
        loadingView.show()
    }

    func hideLoading() {
        loadingView.hide()
    }
}
