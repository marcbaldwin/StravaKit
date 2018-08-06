import Foundation

public extension URL {

    public static func viewInStrava(activityId: Int) -> URL? {
        return URL(string: "https://www.strava.com/activities/\(activityId)")
    }
}
