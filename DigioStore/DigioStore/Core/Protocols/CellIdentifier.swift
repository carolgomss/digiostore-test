protocol CellIdentifier {
    static var identifier: String { get }
}

extension CellIdentifier {
    public static var identifier: String {
        String(describing: Self.self)
    }
}
