import Foundation

extension NSURL {

    var params: [String : String] {

        var params = [String : String]()

        if let query = self.query {
            let keyValues = query.characters.split {$0 == "&" }.map(String.init)
            for keyValue in keyValues {
                let keyValueArray = keyValue.characters.split(2, allowEmptySlices: true, isSeparator: { $0 == "="}).map(String.init)
                params[keyValueArray[0]] = keyValueArray[1]
            }
        }

        return params
    }
}
