import Foundation

protocol ErrorPresenting: AnyObject {
    func displayError(_ error: DigioError)
}
