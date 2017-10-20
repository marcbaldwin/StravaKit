import XCTest
import Nimble
@testable import StravaKit

class RouteTests: XCTestCase {

    func test_decode_route() throws {
        let jsonString = """
            {
                "id" : 123,
                "name" : "Test Route",
                "description" : "Test route for Strava",
                "map" : {
                    "id": "a32193479",
                    "polyline": "kiteFpCBCD]",
                    "summary_polyline": "{cteFjcaBkCx@gEz@",
                }
            }
        """
        let jsonData = jsonString.data(using: .utf8)!
        let route = try JSONDecoder().decode(Route.self, from: jsonData)

        expect(route.id) == 123
        expect(route.name) == "Test Route"
        expect(route.description) == "Test route for Strava"
        expect(route.map.id) == "a32193479"
        expect(route.map.polyline) == "kiteFpCBCD]"
        expect(route.map.summaryPolyline) == "{cteFjcaBkCx@gEz@"
    }
}
