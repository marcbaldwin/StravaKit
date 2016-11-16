public typealias Stream = [DataPoint]

public enum StreamType: String {
    case latLng = "latlng"
    case distance = "distance"
    case altitude = "altitude"
    case speed = "velocity_smooth"
    case time = "time"
}

public struct DataPoint {

    let distance: Distance?
    let coordinate: Coordinate?
    let elevation: Distance?
    let speed: Speed?
    let time: Time?
    var averageSpeed: Speed! {
        return time! == 0 ? 0 : Speed(Double(distance!) / Double(time!))
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

    func distance(_ distance: Distance?) -> DataPointBuilder {
        self.distance = distance
        return self
    }

    func coordinate(_ coordinate: Coordinate?) -> DataPointBuilder {
        self.coordinate = coordinate
        return self
    }

    func elevation(_ elevation: Distance?) -> DataPointBuilder {
        self.elevation = elevation
        return self
    }

    func speed(_ speed: Speed?) -> DataPointBuilder {
        self.speed = speed
        return self
    }

    func time(_ time: Time?) -> DataPointBuilder {
        self.time = time
        return self
    }

    func build() -> DataPoint {
        return DataPoint(builder: self)
    }
}
