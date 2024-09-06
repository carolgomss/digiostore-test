import UIKit

protocol HomeSpotlightViewDelegate: AnyObject {
     func didSelectSpotlight(_ spotlight: Spotlight)
}

class HomeSpotlightView: UIView {

    fileprivate enum Layout { }

    // MARK: - Public properties
    weak var delegate: HomeSpotlightViewDelegate?

    // MARK: - Properties
    private var spotlight: [Spotlight] = []

    // MARK: - Layout
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 12, bottom: 0, right: 12)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeSpotlightCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeSpotlightCollectionViewCell.identifier)
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

    func load(spotlight: [Spotlight]) {
        self.spotlight = spotlight
        collectionView.reloadData()
    }
}

extension HomeSpotlightView: ViewConfiguration {
    func setupViews() {
        addSubviews(collectionView)
    }

    func setupConstraints() {
        [
            heightAnchor.constraint(equalToConstant: Layout.View.height)
        ].activate()
        [
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ].activate()
    }
}

extension HomeSpotlightView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        spotlight.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                                HomeSpotlightCollectionViewCell.identifier,
                                                            for: indexPath) as? HomeSpotlightCollectionViewCell,
              let item = spotlight[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.load(spotlight: item)
        return cell
    }
}

extension HomeSpotlightView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = spotlight[safe: indexPath.row] else {
            return
        }
        delegate?.didSelectSpotlight(item)
    }
}

extension HomeSpotlightView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width - Layout.CollectionViewCell.horizontalSpace,
               height: collectionView.bounds.height)
    }
}

extension HomeSpotlightView.Layout {

    enum View {
        static let height: CGFloat = 200
    }

    enum CollectionViewCell {
        static let horizontalSpace: CGFloat = 32
    }
}
