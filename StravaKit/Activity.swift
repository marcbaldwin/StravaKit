public struct Activity {

    public let id: Int
    public let name: String
    public let distance: Distance
    public let movingTime: Duration
    public let elapsedTime: Duration
    public let totalElevationGain: Distance
    public let averageSpeed: Speed
    public let maxSpeed: Speed
    public let type: String
    public let startDate: String
    public let localTimeZone: String
    public let polyline: String
    public let isStaticTrainer: Bool
    public let isCommute: Bool
    public let isManual: Bool
    public let averageHeartRate: Float
    public let maxHeartRate: Float
}

extension Activity: Equatable { }

public func ==(lhs: Activity, rhs: Activity) -> Bool {
    return lhs.id == rhs.id
}