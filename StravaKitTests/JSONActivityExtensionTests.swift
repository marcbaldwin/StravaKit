import XCTest
import Nimble
import SwiftyJSON
@testable import StravaKit

class JSONActivityEtensionTests: XCTestCase {

    var data: Data { return (try! Data(contentsOf: URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "Activity", ofType: "json")!))) }

    func testShouldConvertJSONToActivity() {
        let activity = JSON(data: data).activity!

        expect(activity.id).to(equal(8529483))
        expect(activity.name).to(equal("08/23/2013 Oakland, CA"))
        expect(activity.distance).to(equal(32486.1))
        expect(activity.movingTime).to(equal(5241))
        expect(activity.elapsedTime).to(equal(5427))
        expect(activity.totalElevationGain).to(equal(566.0))
        expect(activity.type).to(equal("Ride"))
        expect(activity.startDate).to(equal("2013-08-24T00:04:12Z"))
        expect(activity.localTimeZone).to(equal("(GMT-08:00) America/Los_Angeles"))
        expect(activity.polyline).to(equal("cetewLja@zYcG"))
        expect(activity.isStaticTrainer).to(equal(false))
        expect(activity.isCommute).to(equal(false))
        expect(activity.isManual).to(equal(false))
        expect(activity.averageSpeed).to(equal(3.4))
        expect(activity.maxSpeed).to(equal(4.514))
        expect(activity.averageHeartRate).to(equal(138.8))
        expect(activity.maxHeartRate).to(equal(179.0))
    }
}
