@testable import DigioStore
import Foundation

class DigioServiceMock: DigioServiceProtocol {

    private var file: String

    init(file: String) {
        self.file = file
    }

    func get<T: Codable>(path: String,
                         completion: @escaping (Result<T, DigioStore.DigioError>) -> Void) {
        let bundle = Bundle(for: type(of: self))
        guard let bundle = bundle.url(forResource: self.file, withExtension: "json") else {
            return completion(.failure(.invalidPath))
        }
        do {
            guard let data = try? Data(contentsOf: bundle) else {
                return completion(.failure(.invalidResponse))
            }
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.invalidResponse))
        }
    }
}
