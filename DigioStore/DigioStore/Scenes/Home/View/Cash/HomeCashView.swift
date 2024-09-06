import UIKit

protocol HomeCashViewDelegate: AnyObject {
    func didSelectCash(_ cash: Cash)
}

class HomeCashView: UIView {

    fileprivate enum Layout { }

    private var cash: Cash?
    weak var delegate: HomeCashViewDelegate?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var mainImageView: UIImageView = {
        UIImageView()
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func load(cash: Cash) {
        self.cash = cash
        mainImageView.load(source: cash.bannerURL)
        setupTitle()
    }

    private func setupTitle() {
        let title = cash?.title.components(separatedBy: " ").first ?? ""
        let subtitle = cash?.title.components(separatedBy: " ").last ?? ""

        let titleAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.primary,
                                                              .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        let subtitleAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.secondary,
                                                                 .font: UIFont.systemFont(ofSize: 20, weight: .bold)]

        let partOne = NSMutableAttributedString(string: title,
                                                attributes: titleAttributes)
        let partTwo = NSMutableAttributedString(string: " \(subtitle)",
                                                attributes: subtitleAttributes)
        partOne.append(partTwo)
        titleLabel.attributedText = partOne
    }
}

extension HomeCashView: ViewConfiguration {
    func setupViews() {
        addSubviews(titleLabel, mainImageView)
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
            mainImageView.heightAnchor.constraint(equalToConstant: Layout.Image.height),
            mainImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                               constant: Layout.Image.top),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: Layout.Image.leading),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: Layout.Image.trailing)
        ].activate()
    }

    func setupAdditionals() {
        mainImageView.setCornerRadius(.small)

        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }

    @objc func didTap() {
        guard let cash = cash else {
            return
        }
        delegate?.didSelectCash(cash)
    }
}

extension HomeCashView.Layout {

    enum View {
        static let height: CGFloat = 180
    }

    enum Title {
        static let top: CGFloat = 26
        static let leading: CGFloat = 16
        static let trailing: CGFloat = 16
    }

    enum Image {
        static let top: CGFloat = 16
        static let leading: CGFloat = 16
        static let trailing: CGFloat = -16
        static let height: CGFloat = 110
    }
}
