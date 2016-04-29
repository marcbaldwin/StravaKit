import Foundation

extension String {

    subscript (i: Int) -> Character {
        return self[startIndex.advancedBy(i)]
    }

    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    subscript (r: Range<Int>) -> String {
        return substringWithRange(startIndex.advancedBy(r.startIndex) ..< startIndex.advancedBy(r.endIndex))
    }

    var fileURL: NSURL? {
        return NSURL(fileURLWithPath: self)
    }

    var URL: NSURL? {
        return NSURL(string: self)
    }

    func format(args: CVarArgType...) -> String {
        return withVaList(args) {
            return NSString(format: self, arguments: $0) as String
        }
    }
}