import UIKit

// DS = Digio Store
class DSImageView: UIView {
    fileprivate enum Layout { }

    private lazy var mainImageView: UIImageView = {
        UIImageView()
    }()

    private lazy var shadowView: UIView = {
        UIView()
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func load(source: String?,
              custom: ImageLoaderCustom? = .default,
              contentMode: UIView.ContentMode = .scaleAspectFill,
              completion: ((UIImage?) -> Void)? = nil) {
        shadowView.alpha = 0
        mainImageView.load(source: source,
                           custom: custom,
                           contentMode: contentMode,
                           completion: { [weak self] image in
            UIView.animate(withDuration: 1) {
                self?.shadowView.alpha = 1
            }
            completion?(image)
        })
    }

    func prepareForReuse() {
        mainImageView.image = nil
        shadowView.alpha = 0
    }
}

extension DSImageView: ViewConfiguration {
    func setupViews() {
        addSubviews(shadowView,
                    mainImageView)
    }

    func setupConstraints() {
        [
            mainImageView.topAnchor.constraint(equalTo: topAnchor,
                                               constant: Layout.Image.top),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                  constant: Layout.Image.bottom)
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

        mainImageView.setCornerRadius(.big)

        shadowView.backgroundColor = .white
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .init(width: 2, height: 2)
        shadowView.layer.shadowRadius = 5
    }
}

extension DSImageView.Layout {

    enum Image {
        static let top: CGFloat = 10
        static let bottom: CGFloat = -10
        static let leading: CGFloat = 10
        static let trailing: CGFloat = -10
    }

    enum Shadow {
        static let top: CGFloat = 15
        static let bottom: CGFloat = -15
        static let leading: CGFloat = 5
        static let trailing: CGFloat = -5
    }
}
