import UIKit

class DetaiView: UIView {

    fileprivate enum Layout { }

    private lazy var iconImageView: UIImageView = {
        UIImageView()
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .primary(ofSize: 26)
        label.textColor = .primary
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .primary(ofSize: 18)
        label.textColor = .secondary
        return label
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func load(product: Product) {
        iconImageView.load(source: product.imageURL)
        titleLabel.text = product.name
        descriptionLabel.text = product.description
    }
}

extension DetaiView: ViewConfiguration {
    func setupViews() {
        addSubviews(iconImageView,
                    titleLabel,
                    descriptionLabel)
    }

    func setupConstraints() {
        [
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: Layout.Icon.height)
        ].activate()
        [
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor,
                                            constant: Layout.Title.top),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Layout.Title.top),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: Layout.Title.top)
        ].activate()
        [
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                  constant: Layout.Description.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: Layout.Description.top),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: Layout.Description.top)
        ].activate()
    }
}

extension DetaiView.Layout {

    enum Icon {
        static let height: CGFloat = 100
    }

    enum Title {
        static let top: CGFloat = 16
        static let leading: CGFloat = 16
        static let trailing: CGFloat = -16
    }

    enum Description {
        static let top: CGFloat = 16
        static let leading: CGFloat = 16
        static let trailing: CGFloat = -16
    }
}
