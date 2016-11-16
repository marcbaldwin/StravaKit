import Foundation

extension String {

    func dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self
        return dateFormatter
    }
}
