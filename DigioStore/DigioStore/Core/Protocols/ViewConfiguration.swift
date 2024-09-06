protocol ViewConfiguration: AnyObject {
    func setup()
    func setupViews()
    func setupConstraints()
    func setupAdditionals()
}

extension ViewConfiguration {
    func setup() {
        setupViews()
        setupConstraints()
        setupAdditionals()
    }

    func setupAdditionals() {
        // Opcional
    }
}
