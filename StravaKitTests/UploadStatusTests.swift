import XCTest
import Nimble
@testable import StravaKit

class UploadStatusTests: XCTestCase {

    func test_decode_route() throws {
        let jsonString = """
            {
              "id": 16486788,
              "external_id": "test.fit",
              "error": null,
              "status": "Your activity is ready.",
              "activity_id": 14296970
            }
        """
        let jsonData = jsonString.data(using: .utf8)!
        let uploadStatus = try JSONDecoder().decode(UploadStatus.self, from: jsonData)

        expect(uploadStatus.id) == 16486788
        expect(uploadStatus.externalId) == "test.fit"
        expect(uploadStatus.error).to(beNil())
        expect(uploadStatus.status) == "Your activity is ready."
        expect(uploadStatus.activityId) == 14296970
    }
}

