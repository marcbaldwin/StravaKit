import XCTest
import Nimble
import SwiftyJSON
@testable import StravaKit

class JSONToAthleteTests: XCTestCase {

    func testShouldConvertJSONToAthlete() {
        let data = NSData(contentsOfFile: NSBundle(forClass: self.dynamicType).pathForResource("Athlete", ofType: "json")!)!
        let athlete = JSON(data: data).athlete!

        expect(athlete.username).to(equal("marc_baldwin"))
        expect(athlete.email).to(equal("marc.baldwin88@gmail.com"))
        expect(athlete.firstName).to(equal("Marc"))
        expect(athlete.lastName).to(equal("Baldwin"))
        expect(athlete.premium).to(beFalse())
        expect(athlete.measurementPreference).to(equal(MeasurementPreference.Meters))
    }
}