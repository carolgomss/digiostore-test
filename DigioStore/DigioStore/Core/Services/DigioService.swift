import Foundation

protocol DigioServiceProtocol: AnyObject {
    func get<T: Codable>(path: String, completion: @escaping (Result<T, DigioError>) -> Void)
}

class DigioService: DigioServiceProtocol {

    func get<T: Codable>(path: String, completion: @escaping (Result<T, DigioError>) -> Void) {
        request(path: path, method: .get, completion: completion)
    }

    func request<T: Codable>(path: String, method: DigioMethod, completion: @escaping (Result<T, DigioError>) -> Void) {
        guard let baseURL = EnvironmentManager.shared.baseURL,
              let url = URL(string: baseURL.appending(path)) else {
            let error = DigioError.invalidURL
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, _, error in
            guard let data else {
                let error = DigioError.invalidURL
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                debugPrint(error)
                let error = DigioError.invalidResponse
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

enum DigioMethod: String {
    case get = "GET"
    case post = "POST"
}
