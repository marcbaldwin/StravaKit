import Foundation
import Alamofire
import SwiftyJSON

private let activitiesTemplate = "https://www.strava.com/api/v3/athlete/activities"
private let streamsTemplate = "https://www.strava.com/api/v3/activities/%d/streams/%@"

private let MaxPageSize = 200

extension StravaClient {

    func activitiesForLocalAthlete(from: NSDate, to: NSDate, success: ([Activity]) -> (), failure: ErrorHandler) {

        let parameters = [
            "before" : to.timeIntervalSince1970,
            "after" : from.timeIntervalSince1970
        ]

        performGetRequest(activitiesTemplate, parameters: parameters, success: { json in

            var activities = [Activity]()
            if let jsonArray = JSON(json).array {
                for activityJSON in jsonArray {
                    activities.append(activityJSON.activity)
                }
            }
            success(activities)

        }) { error in
            failure(error)
        }
    }

    func activityStreamForActivityWithId(id: Int, types: [StreamType], success: (ActivityStream) -> (), failure: ErrorHandler) {

        let typeString = types.reduce("") { $0.0 + $0.1.rawValue + "," }
        let url = streamsTemplate.format(id, typeString)

        performGetRequest(url, parameters: ["resolution" : "low"], success: { json in

            let json = JSON(json)
            success(json.activityStream)

        }) { error in
            failure(error)
        }
    }
}