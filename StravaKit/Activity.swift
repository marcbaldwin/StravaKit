public class Activity {

    public var id: Int!
    public var name: String!
    public var distance: Distance!
    public var movingTime: Duration!
    public var elapsedTime: Duration!
    public var totalElevationGain: Distance!

    public var averageSpeed: Speed!
    public var maxSpeed: Speed!

    public var type: String!

    public var startDate: NSDate!
    public var localTimeZone: NSTimeZone!

    public var polyline: String!
    public var startCoordinate: Coordinate!
    public var endCoordinate: Coordinate!

    public var achievementCount: Int!
    public var kudosCount: Int!
    public var commentCount: Int!
    public var athleteCount: Int!
    public var photoCount: Int!
    public var totalPhotoCount: Int!
    public var isStaticTrainer: Bool!
    public var isCommute: Bool!
    public var isManual: Bool!
    public var isPrivate: Bool!
    public var isFlagged: Bool!
    public var averageWatts: Float!
    public var weightedAverageWatts: Float!
    public var kilojoules: Float!
    public var deviceWatts: Bool!
    public var averageHeartRate: Float!
    public var maxHeartRate: Float!

    public init() {}
}