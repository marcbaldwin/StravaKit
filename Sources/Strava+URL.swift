import Foundation

public extension URL {

    static func viewInStrava(activityId: Int64) -> URL {
        return URL(string: "https://www.strava.com/activities/\(activityId)")!
    }
}
