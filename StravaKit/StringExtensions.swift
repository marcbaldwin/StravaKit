import Foundation

extension String {

    subscript (i: Int) -> Character {
        return self[characters.index(startIndex, offsetBy: i)]
    }

    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    subscript (r: Range<Int>) -> String {
        return substring(with: characters.index(startIndex, offsetBy: r.lowerBound) ..< characters.index(startIndex, offsetBy: r.upperBound))
    }

    var fileURL: Foundation.URL? {
        return Foundation.URL(fileURLWithPath: self)
    }

    var URL: Foundation.URL? {
        return Foundation.URL(string: self)
    }

    func format(_ args: CVarArg...) -> String {
        return withVaList(args) {
            return NSString(format: self, arguments: $0) as String
        }
    }
}
