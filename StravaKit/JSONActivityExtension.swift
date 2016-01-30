import Foundation
import SwiftyJSON

extension JSON {

    var activity: Activity {

        let activity = Activity()
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
        dateFormat.timeZone = NSTimeZone(abbreviation: "UTC")

        activity.id = self["id"].int!
        activity.name = self["name"].string!
        activity.distance = self["distance"].floatValue
        activity.movingTime = self["moving_time"].doubleValue
        activity.elapsedTime = self["elapsed_time"].doubleValue
        activity.totalElevationGain = self["total_elevation_gain"].floatValue
        activity.type = self["type"].string!
        activity.startDate = dateFormat.dateFromString(self["start_date"].stringValue)
        activity.localTimeZone = NSTimeZone(name: self["timezone"].stringValue.characters.split { $0 == " "}.map(String.init)[1])
        activity.startCoordinate = self["start_latlng"].coordinate
        activity.endCoordinate = self["end_latlng"].coordinate
        activity.achievementCount = self["achievement_count"].int!
        activity.kudosCount = self["kudos_count"].int!
        activity.commentCount = self["comment_count"].int!
        activity.athleteCount = self["athlete_count"].int!
        activity.photoCount = self["photo_count"].int!
        activity.totalPhotoCount = self["total_photo_count"].int!
        activity.isStaticTrainer = self["trainer"].boolValue
        activity.isCommute = self["commute"].boolValue
        activity.isManual = self["manual"].boolValue
        activity.isPrivate = self["private"].boolValue
        activity.isFlagged = self["flagged"].boolValue
        activity.averageSpeed = self["average_speed"].floatValue
        activity.maxSpeed = self["max_speed"].floatValue
        activity.averageWatts = self["average_watts"].floatValue
        activity.weightedAverageWatts = self["weighted_average_watts"].floatValue
        activity.kilojoules = self["kilojoules"].floatValue
        activity.deviceWatts = self["device_watts"].boolValue
        activity.averageHeartRate = self["average_heartrate"].floatValue
        activity.maxHeartRate = self["max_heartrate"].floatValue

        return activity
    }
}
