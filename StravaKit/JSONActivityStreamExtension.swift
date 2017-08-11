import CoreLocation
import SwiftyJSON

extension JSON {

    public var activityStream: ActivityStream {

        let coordinates = self.coodinates()
        let distances = dataArray("distance") as? [CLLocationDistance]
        let altitudes = dataArray("altitude") as? [CLLocationDistance]
        let speeds = dataArray("velocity_smooth") as? [CLLocationSpeed]
        let times = dataArray("time") as? [TimeInterval]

        return ActivityStream(
            distance: distances, coordinate: coordinates, elevation: altitudes, speed: speeds, time: times
        )
    }

    private func dataArray(_ name: String) -> [AnyObject]? {
        let rawArray = jsonWithType(name)
        return rawArray?.arrayObject as [AnyObject]?
    }

    private func coodinates() -> [CLLocationCoordinate2D]? {
        return jsonWithType("latlng")?.coordinates
    }

    private func jsonWithType(_ type: String) -> JSON? {
        for object in self {
            if object.1["type"].string == type {
                return object.1["data"]
            }
        }
        return nil
    }
}
