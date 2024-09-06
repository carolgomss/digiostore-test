import UIKit

class LoadingView: UIView {

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .gray
        view.tintColor = .gray
        return view
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func show() {
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.alpha = 1
        }
    }

    func hide() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.alpha = 0
        } completion: { [weak self] finished in
            if finished {
                self?.isHidden = true
            }
        }
    }
}

extension LoadingView: ViewConfiguration {
    func setupViews() {
        addSubviews(activityIndicatorView)
    }

    func setupConstraints() {
        [
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ].activate()
    }

    func setupAdditionals() {
        activityIndicatorView.startAnimating()
    }
}
