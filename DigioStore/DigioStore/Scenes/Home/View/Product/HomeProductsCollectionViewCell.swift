import UIKit

class HomeProductsCollectionViewCell: UICollectionViewCell, CellIdentifier {
    fileprivate enum Layout { }

    private var product: Product?

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var mainImageView: UIImageView = {
        UIImageView()
    }()

    private lazy var shadowView: UIView = {
        UIView()
    }()

    func load(product: Product) {
        self.product = product
        mainImageView.load(source: product.imageURL,
                           contentMode: .scaleAspectFit)
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
        mainImageView.image = nil
    }
}

extension HomeProductsCollectionViewCell: ViewConfiguration {
    func setupViews() {
        addSubviews(shadowView,
                    containerView)
        containerView.addSubviews(mainImageView)
    }

    func setupConstraints() {
        [
            containerView.topAnchor.constraint(equalTo: topAnchor,
                                               constant: Layout.View.top),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: Layout.View.leading),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: Layout.View.trailing),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                  constant: Layout.View.bottom)
        ].activate()
        [
            mainImageView.widthAnchor.constraint(equalToConstant: Layout.Image.size),
            mainImageView.heightAnchor.constraint(equalToConstant: Layout.Image.size),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ].activate()
        [
            shadowView.topAnchor.constraint(equalTo: topAnchor,
                                            constant: Layout.Shadow.top),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Layout.Shadow.leading),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: Layout.Shadow.trailing),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                               constant: Layout.Shadow.bottom)
        ].activate()
    }

    func setupAdditionals() {
        backgroundColor = .white

        containerView.setCornerRadius(.big)
        mainImageView.setCornerRadius(.small)

        shadowView.backgroundColor = .white
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .init(width: 2, height: 2)
        shadowView.layer.shadowRadius = 4
    }
}

extension HomeProductsCollectionViewCell.Layout {

    enum View {
        static let top: CGFloat = 16
        static let bottom: CGFloat = -16
        static let leading: CGFloat = 5
        static let trailing: CGFloat = -5
    }

    enum Image {
        static let size: CGFloat = 60
    }

    enum Shadow {
        static let top: CGFloat = 22
        static let bottom: CGFloat = -22
        static let leading: CGFloat = 10
        static let trailing: CGFloat = -10
    }
}
