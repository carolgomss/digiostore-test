import UIKit

protocol HomeProductViewDelegate: AnyObject {
     func didSelectProduct(_ product: Product)
}

class HomeProductView: UIView {

    fileprivate enum Layout { }
    fileprivate enum Strings { }

    // MARK: - Public properties
    weak var delegate: HomeProductViewDelegate?

    // MARK: - Properties
    private var products: [Product] = []

    // MARK: - Layout
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .primary(ofSize: 16)
        label.textColor = .primary
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 18, bottom: 0, right: 18)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeProductsCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeProductsCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func load(products: [Product]) {
        self.products = products
        collectionView.reloadData()
        titleLabel.text = Strings.Title.title
    }
}

extension HomeProductView: ViewConfiguration {
    func setupViews() {
        addSubviews(titleLabel, collectionView)
    }

    func setupConstraints() {
        [
            heightAnchor.constraint(equalToConstant: Layout.View.height)
        ].activate()
        [
            titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                            constant: Layout.Title.top),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Layout.Title.leading),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: Layout.Title.trailing)
        ].activate()
        [
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: Layout.CollectionViewCell.top),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ].activate()
    }
}

extension HomeProductView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                                HomeProductsCollectionViewCell.identifier,
                                                            for: indexPath) as? HomeProductsCollectionViewCell,
              let item = products[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.load(product: item)
        return cell
    }
}

extension HomeProductView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = products[safe: indexPath.row] else {
            return
        }
        delegate?.didSelectProduct(item)
    }
}

extension HomeProductView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Layout.CollectionViewCell.width,
               height: Layout.CollectionViewCell.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Layout.CollectionViewCell.spacingForSection
    }
}

extension HomeProductView.Layout {

    enum View {
        static let height: CGFloat = 170
    }

    enum Title {
        static let top: CGFloat = 26
        static let leading: CGFloat = 16
        static let trailing: CGFloat = 16
    }

    enum CollectionViewCell {
        static let top: CGFloat = 22
        static let width: CGFloat = 110
        static let height: CGFloat = 125
        static let spacingForSection: CGFloat = 2
    }
}

extension HomeProductView.Strings {

    enum Title {
        static let title: String = "Produtos"
    }
}
