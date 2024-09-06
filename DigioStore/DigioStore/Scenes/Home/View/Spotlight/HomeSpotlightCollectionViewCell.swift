import UIKit

class HomeSpotlightCollectionViewCell: UICollectionViewCell, CellIdentifier {
    fileprivate enum Layout { }

    private var spotlight: Spotlight?

    private lazy var mainImageView: DSImageView = {
        DSImageView()
    }()

    func load(spotlight: Spotlight) {
        self.spotlight = spotlight
        mainImageView.load(source: spotlight.bannerURL)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.prepareForReuse()
    }
}

extension HomeSpotlightCollectionViewCell: ViewConfiguration {
    func setupViews() {
        contentView.addSubviews(mainImageView)
    }

    func setupConstraints() {
        [
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: Layout.Image.top),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: Layout.Image.bottom)
        ].activate()
    }
}

extension HomeSpotlightCollectionViewCell.Layout {

    enum Image {
        static let top: CGFloat = 10
        static let bottom: CGFloat = -10
    }
}
