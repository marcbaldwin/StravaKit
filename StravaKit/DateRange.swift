import Foundation

struct DateRange {

    let start: NSDate
    let end: NSDate

    init(_ start: NSDate, _ end: NSDate) {
        self.start = start
        self.end = end
    }

    func daySpan() -> Int {
        return NSCalendar.currentCalendar().components(.Day, fromDate: start, toDate: end, options: []).day
    }

    func day(day: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: day, toDate: start, options: [])!
    }
}