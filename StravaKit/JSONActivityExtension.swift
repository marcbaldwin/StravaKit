import SwiftyJSON

extension JSON {

    public var activities: [Activity] {
        return array?.flatMap({ $0.activity }) ?? [Activity]()
    }

    public var activity: Activity? {
        guard let id = self["id"].int else { return nil }

        return Activity(
            id: id,
            name: self["name"].stringValue,
            distance: self["distance"].doubleValue,
            movingTime: self["moving_time"].doubleValue,
            elapsedTime: self["elapsed_time"].doubleValue,
            totalElevationGain: self["total_elevation_gain"].doubleValue,
            averageSpeed: self["average_speed"].doubleValue,
            maxSpeed: self["max_speed"].doubleValue,
            type: self["type"].stringValue,
            startDate: self["start_date"].stringValue,
            localTimeZone: self["timezone"].stringValue,
            polyline: self["map"]["summary_polyline"].string,
            isStaticTrainer: self["trainer"].boolValue,
            isCommute: self["commute"].boolValue,
            isManual: self["manual"].boolValue,
            averageHeartRate: self["average_heartrate"].floatValue,
            maxHeartRate: self["max_heartrate"].floatValue)
    }
}
