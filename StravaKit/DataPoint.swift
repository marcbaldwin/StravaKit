public typealias Stream = [DataPoint]

public enum StreamType: String {
    case LatLng = "latlng"
    case Distance = "distance"
    case Altitude = "altitude"
    case Speed = "velocity_smooth"
    case Time = "time"
}

public struct DataPoint {

    let distance: Distance?
    let coordinate: Coordinate?
    let elevation: Distance?
    let speed: Speed?
    let time: Time?
    var averageSpeed: Speed! {
        return time! == 0 ? 0 : Speed(Double(distance!) / time!)
    }

    init(builder: DataPointBuilder) {
        self.distance = builder.distance
        self.coordinate = builder.coordinate
        self.elevation = builder.elevation
        self.speed = builder.speed
        self.time = builder.time
    }
}

// MARK: Builder

class DataPointBuilder {

    var distance: Distance? = nil
    var coordinate: Coordinate? = nil
    var elevation: Distance? = nil
    var speed: Speed? = nil
    var time: Time? = nil

    init() {

    }

    func distance(distance: Distance?) -> DataPointBuilder {
        self.distance = distance
        return self
    }

    func coordinate(coordinate: Coordinate?) -> DataPointBuilder {
        self.coordinate = coordinate
        return self
    }

    func elevation(elevation: Distance?) -> DataPointBuilder {
        self.elevation = elevation
        return self
    }

    func speed(speed: Speed?) -> DataPointBuilder {
        self.speed = speed
        return self
    }

    func time(time: Time?) -> DataPointBuilder {
        self.time = time
        return self
    }

    func build() -> DataPoint {
        return DataPoint(builder: self)
    }
}