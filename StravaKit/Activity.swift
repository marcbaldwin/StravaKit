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

    public let startDate: NSDate
    public let localTimeZone: NSTimeZone

    public let polyline: String
    public let startCoordinate: Coordinate
    public let endCoordinate: Coordinate

    public let achievementCount: Int
    public let kudosCount: Int
    public let commentCount: Int
    public let athleteCount: Int
    public let photoCount: Int
    public let totalPhotoCount: Int
    public let isStaticTrainer: Bool
    public let isCommute: Bool
    public let isManual: Bool
    public let isPrivate: Bool
    public let isFlagged: Bool
    public let averageWatts: Float
    public let weightedAverageWatts: Float
    public let kilojoules: Float
    public let deviceWatts: Bool
    public let averageHeartRate: Float
    public let maxHeartRate: Float

    public init(builder: ActivityBuilder) {
        id = builder.id
        name = builder.name
        distance = builder.distance
        movingTime = builder.movingTime
        elapsedTime = builder.elapsedTime
        totalElevationGain = builder.totalElevationGain
        averageSpeed = builder.averageSpeed
        maxSpeed = builder.maxSpeed
        type = builder.type
        startDate = builder.startDate
        localTimeZone = builder.localTimeZone
        polyline = builder.polyline
        startCoordinate = builder.startCoordinate
        endCoordinate = builder.endCoordinate
        achievementCount = builder.achievementCount
        kudosCount = builder.kudosCount
        commentCount = builder.commentCount
        athleteCount = builder.athleteCount
        photoCount = builder.photoCount
        totalPhotoCount = builder.totalPhotoCount
        isStaticTrainer = builder.isStaticTrainer
        isCommute = builder.isCommute
        isManual = builder.isManual
        isPrivate = builder.isPrivate
        isFlagged = builder.isFlagged
        averageWatts = builder.averageWatts
        weightedAverageWatts = builder.weightedAverageWatts
        kilojoules = builder.kilojoules
        deviceWatts = builder.deviceWatts
        averageHeartRate = builder.averageHeartRate
        maxHeartRate = builder.maxHeartRate
    }
}

public class ActivityBuilder {

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

    public init() { }

    public func build() -> Activity {
        return Activity(builder: self)
    }
}