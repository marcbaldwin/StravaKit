class ActivityGroup {

    let dateRange: DateRange
    let activities: [Activity]

    init(dateRange: DateRange, activities: [Activity]) {
        self.dateRange = dateRange
        self.activities = activities
    }

    func activitiesForDay(day: Int) -> [Activity] {

        let targetDate = dateRange.day(day)
        return activities.filter {
            let dateComponents = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: $0.startDate)
            let date = NSCalendar.currentCalendar().dateFromComponents(dateComponents)
            return date == targetDate
        }
    }
}