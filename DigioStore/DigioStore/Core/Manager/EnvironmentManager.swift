enum Environment {
    case production
    case development

    var baseURL: String? {
        switch self {
        case .production:
            return InfoPlist.value(for: "BASE_URL_PROD")
        case .development:
            return InfoPlist.value(for: "BASE_URL_DEV")
        }
    }
}

class EnvironmentManager {

    static let shared: Environment = .production
}
