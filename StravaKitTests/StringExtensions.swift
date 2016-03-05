import Foundation

extension String {

    func dateFormatter() -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = self
        return dateFormatter
    }
}