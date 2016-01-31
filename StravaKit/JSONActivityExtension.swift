import SwiftyJSON

extension JSON {

    var activities: [Activity] { return array!.map({ $0.activity }) }

    var activity: Activity {

        let builder = ActivityBuilder()
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
        dateFormat.timeZone = NSTimeZone(abbreviation: "UTC")

        builder.id = self["id"].int!
        builder.name = self["name"].string!
        builder.distance = self["distance"].floatValue
        builder.movingTime = self["moving_time"].intValue
        builder.elapsedTime = self["elapsed_time"].intValue
        builder.totalElevationGain = self["total_elevation_gain"].floatValue
        builder.type = self["type"].string!
        builder.startDate = dateFormat.dateFromString(self["start_date"].stringValue)
        builder.localTimeZone = NSTimeZone(name: self["timezone"].stringValue.characters.split { $0 == " "}.map(String.init)[1])
        builder.polyline = self["map"]["summary_polyline"].stringValue
        builder.startCoordinate = self["start_latlng"].coordinate
        builder.endCoordinate = self["end_latlng"].coordinate
        builder.achievementCount = self["achievement_count"].int!
        builder.kudosCount = self["kudos_count"].int!
        builder.commentCount = self["comment_count"].int!
        builder.athleteCount = self["athlete_count"].int!
        builder.photoCount = self["photo_count"].int!
        builder.totalPhotoCount = self["total_photo_count"].int!
        builder.isStaticTrainer = self["trainer"].boolValue
        builder.isCommute = self["commute"].boolValue
        builder.isManual = self["manual"].boolValue
        builder.isPrivate = self["private"].boolValue
        builder.isFlagged = self["flagged"].boolValue
        builder.averageSpeed = self["average_speed"].floatValue
        builder.maxSpeed = self["max_speed"].floatValue
        builder.averageWatts = self["average_watts"].floatValue
        builder.weightedAverageWatts = self["weighted_average_watts"].floatValue
        builder.kilojoules = self["kilojoules"].floatValue
        builder.deviceWatts = self["device_watts"].boolValue
        builder.averageHeartRate = self["average_heartrate"].floatValue
        builder.maxHeartRate = self["max_heartrate"].floatValue

        return builder.build()
    }
}
