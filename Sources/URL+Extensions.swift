import Foundation

public extension URL {

    var params: [String : String] {
        var params = [String : String]()

        if let query = self.query {
            let keyValues = query.split { $0 == "&" } .map(String.init)
            for keyValue in keyValues {
                let keyValueArray = keyValue.split(maxSplits: 2, omittingEmptySubsequences: false, whereSeparator: { $0 == "=" }).map(String.init)
                params[keyValueArray[0]] = keyValueArray[1]
            }
        }

        return params
    }
}
