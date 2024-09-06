import UIKit

protocol DetailDisplayLogic: AnyObject {
    func displayProduct(_ product: Product)
}

class DetailViewController: UIViewController {
    var interactor: DetailBusinessLogic?

    private lazy var detaiView: DetaiView = {
        DetaiView()
    }()

    // MARK: Object lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.loadData()
    }
}

extension DetailViewController: ViewConfiguration {

    func setupViews() {
        view.addSubviews(detaiView)
    }

    func setupConstraints() {
        [
            detaiView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detaiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detaiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detaiView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].activate()
    }

    func setupAdditionals() {
        view.backgroundColor = .white
    }
}

extension DetailViewController: DetailDisplayLogic {

    func displayProduct(_ product: Product) {
        detaiView.load(product: product)
    }
}
