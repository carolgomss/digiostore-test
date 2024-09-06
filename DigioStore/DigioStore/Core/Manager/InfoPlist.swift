import Foundation

class InfoPlist {

    static func value(for key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}
