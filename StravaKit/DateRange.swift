struct DateRange {

    let start: Date
    let end: Date

    init(_ start: Date, _ end: Date) {
        self.start = start
        self.end = end
    }

    func daySpan() -> Int {
        return (Calendar.current as NSCalendar).components(.day, from: start, to: end, options: []).day!
    }

    func day(_ day: Int) -> Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: day, to: start, options: [])!
    }
}
