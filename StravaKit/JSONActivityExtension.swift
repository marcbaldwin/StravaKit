import SwiftyJSON

extension JSON {

    var activities: [Activity] {
        return array?.flatMap({ $0.activity }) ?? [Activity]()
    }

    var activity: Activity? {
        guard let id = self["id"].int else { return nil }

        return Activity(
            id: id,
            name: self["name"].stringValue,
            distance: self["distance"].floatValue,
            movingTime: self["moving_time"].intValue,
            elapsedTime: self["elapsed_time"].intValue,
            totalElevationGain: self["total_elevation_gain"].floatValue,
            averageSpeed: self["average_speed"].floatValue,
            maxSpeed: self["max_speed"].floatValue,
            type: self["type"].stringValue,
            startDate: self["start_date"].stringValue,
            localTimeZone: self["timezone"].stringValue,
            polyline: self["map"]["summary_polyline"].stringValue,
            isStaticTrainer: self["trainer"].boolValue,
            isCommute: self["commute"].boolValue,
            isManual: self["manual"].boolValue,
            averageHeartRate: self["average_heartrate"].floatValue,
            maxHeartRate: self["max_heartrate"].floatValue)
    }
}
