import UIKit

struct ImageLoaderCustom {
    var placeholder: UIImage?
    var errorImage: UIImage?

    static var `default`: ImageLoaderCustom {
        return .init(placeholder: UIImage(named: "placeholder"),
                     errorImage: UIImage(named: "error_placeholder"))
    }
}

private let internalCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func load(source: String?,
              custom: ImageLoaderCustom? = .default,
              contentMode: UIView.ContentMode = .scaleAspectFill,
              completion: ((UIImage?) -> Void)? = nil) {
        self.contentMode = contentMode
        func setImage(_ image: UIImage?) {
            DispatchQueue.main.async {
                self.image = image
                completion?(image)
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.alpha = 1.0
                }
            }
        }
        alpha = 0.0
        self.image = custom?.placeholder
        guard let source = source,
              let url = URL(string: source) else {
            setImage(custom?.errorImage)
            return
        }
        if let internalCache = internalCache.object(forKey: url as AnyObject) as? UIImage {
            setImage(internalCache)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let img = UIImage(data: data) else {
                setImage(custom?.errorImage)
                return
            }
            internalCache.setObject(img, forKey: url as AnyObject)
            setImage(img)
         }.resume()
    }
}
