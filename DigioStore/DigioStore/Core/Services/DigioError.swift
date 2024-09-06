enum DigioError: Error {
    case invalidURL
    case invalidResponse
    case invalidPath
}

extension DigioError {

    var message: String {
        switch self {
        case .invalidURL:
            return "URL Inválida"
        case .invalidResponse:
            return "Resposta não tratada"
        case .invalidPath:
            return "Caminho inválido"
        }
    }
}
