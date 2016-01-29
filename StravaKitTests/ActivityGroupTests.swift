import XCTest
@testable import StravaKit

class ActivityGroupTests: XCTestCase {

    var activity1: Activity!
    var activity2: Activity!
    var activity3: Activity!

    var activityGroup: ActivityGroup!

    override func setUp() {
        super.setUp()

        let dateFormatter = "YYYY:MM:d".dateFormatter()

        let start = dateFormatter.dateFromString("2015:06:22")!
        let end = dateFormatter.dateFromString("2015:06:29")!

        activity1 = Activity()
        activity1.id = 1
        activity1.startDate = dateFormatter.dateFromString("2015:06:22")!.dateByAddingTimeInterval(3.hours)

        activity2 = Activity()
        activity2.id = 2
        activity2.startDate = dateFormatter.dateFromString("2015:06:22")!

        activity3 = Activity()
        activity3.id = 3
        activity3.startDate = dateFormatter.dateFromString("2015:06:25")!

        activityGroup = ActivityGroup(dateRange: DateRange(start, end), activities: [activity1, activity2, activity3])
    }

    func testShouldGetActivitiesForAGivenDay() {

        let firstDayActivities = activityGroup.activitiesForDay(0)
        XCTAssertEqual(2, firstDayActivities.count)
        XCTAssertEqual(1, firstDayActivities[0].id)
        XCTAssertEqual(2, firstDayActivities[1].id)

        let fourthDayActivities = activityGroup.activitiesForDay(3)
        XCTAssertEqual(1, fourthDayActivities.count)
        XCTAssertEqual(3, fourthDayActivities[0].id)
    }

    func testShouldGetEmptyActivitiesForAGivenDay() {
        XCTAssertTrue(activityGroup.activitiesForDay(1).isEmpty)
    }
}