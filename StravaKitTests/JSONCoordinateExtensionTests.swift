import XCTest
import Nimble
import SwiftyJSON
@testable import StravaKit

class JSONCoordinateExtensionTests: XCTestCase {

    func testShouldConvertJSONToCoordinate() {
        let coordinate = JSON.parse("[50.747492, -1.803626]").coordinate
        expect(coordinate).to(equal(Coordinate(50.747492, -1.803626)))
    }

    func testShouldConvertJSONToCoordinates() {
        let coordinates = JSON.parse("[[50.747493, -1.80385], [50.741435, -1.807686]]").coordinates
        expect(coordinates).to(equal([Coordinate(50.747493, -1.80385), Coordinate(50.741435, -1.807686)]))
    }
}