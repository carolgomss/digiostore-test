import UIKit

class DSHeaderView: UIView {

    fileprivate enum Layout { }

    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo_small")
        return view
    }()

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Olá, Maria"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        nil
    }
}

extension DSHeaderView: ViewConfiguration {
    func setupViews() {
        addSubviews(logoImageView, userNameLabel)
    }

    func setupConstraints() {
        [
            heightAnchor.constraint(equalToConstant: Layout.View.height)
        ].activate()
        [
            logoImageView.heightAnchor.constraint(equalToConstant: Layout.Logo.size),
            logoImageView.widthAnchor.constraint(equalToConstant: Layout.Logo.size),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: Layout.Logo.leading),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ].activate()
        [
            userNameLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor,
                                                   constant: Layout.Title.leading),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: Layout.Title.trailing)
        ].activate()
    }

    func setupAdditionals() {
        logoImageView.setCornerRadius(.small)
    }
}

extension DSHeaderView.Layout {

    enum View {
        static let height: CGFloat = 54
    }

    enum Logo {
        static let size: CGFloat = 44
        static let leading: CGFloat = 16
    }

    enum Title {
        static let leading: CGFloat = 16
        static let trailing: CGFloat = -16
    }
}
