import XCTest
import Foundation

class StravaFormatterTests: XCTestCase {

    var stravaFormatter: StravaFormatter!

    override func setUp() {
        super.setUp()
        stravaFormatter = StravaFormatter()
    }

    // MARK: Date

    func testShouldFormatDateWithDayMonthYear() {
        XCTAssertEqual("19 June 2015", stravaFormatter.formatDate("YYYY:MM:d".dateFormatter().dateFromString("2015:6:19")!))
    }

    // MARK: Distance

    func testShouldFormatDistanceWithKMs() {
        XCTAssertEqual("115.5km", stravaFormatter.formatDistance(115532.0))
    }

    // MARK: Elevation

    func testShouldFormatElevationInMeters() {
        XCTAssertEqual("2015m", stravaFormatter.formatElevation(2015))
    }

    // MARK: Speed

    func testShouldFormatSpeedInKiloMetersPerHourTo1DecimalPlace() {
        XCTAssertEqual("27.3km/h", stravaFormatter.formatSpeed(7.593))
    }

    // MARK: Time

    func testShouldFormatTimeAsHoursMinutesSeconds() {
        XCTAssertEqual("2:35:45", stravaFormatter.formatTime(2.hours + 35.minutes + 45))
    }

    func testShouldFormatTimeAsHoursMinutesSecondsWithMinimumOfTwoDigitsForMinutesAndSeconds() {
        XCTAssertEqual("2:05:05", stravaFormatter.formatTime(2.hours + 5.minutes + 5))
    }

    func testShouldFormatTimeAsMinutesSecondsWhenLessThanAnHour() {
        XCTAssertEqual("35:45", stravaFormatter.formatTime(35.minutes + 45))
    }

    func testShouldFormatTimeAsMinutesSecondsWhenLessThanAnHourWithMinimumOfTwoDigitsForSeconds() {
        XCTAssertEqual("5:05", stravaFormatter.formatTime(5.minutes + 5))
    }
}