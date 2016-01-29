import Foundation
import SwiftyJSON

extension JSON {

    var activityStream: ActivityStream {

        let coordinates = self.coodinates()
        let distances = dataArray("distance") as? [Distance]
        let altitudes = dataArray("altitude") as? [Distance]
        let speeds = dataArray("velocity_smooth") as? [Speed]
        let times = dataArray("time") as? [Time]

        var dataPoints = [DataPoint]()

        for i in 0..<distances!.count {
            let dataPoint = DataPointBuilder()
                .distance(distances?[i])
                .coordinate(coordinates?[i])
                .elevation(altitudes?[i])
                .speed(speeds?[i])
                .time(times?[i])
                .build()
            dataPoints.append(dataPoint)
        }

        return ActivityStream(dataPoints: dataPoints)
    }

    private func dataArray(name: String) -> [AnyObject]? {
        let rawArray = jsonWithType(name)
        return rawArray == nil ? nil : rawArray?.arrayObject
    }

    private func coodinates() -> [Coordinate]? {
        if let coordinatesAsJson = jsonWithType("latlng") {
            var coordinates = [Coordinate]()

            for coordinateAsJson in coordinatesAsJson.array! {
                let coordinateAsArray = coordinateAsJson.arrayObject as! [Degrees]
                let coordinate = Coordinate(lat: coordinateAsArray[0], lng: coordinateAsArray[1])
                coordinates.append(coordinate)
            }

            return coordinates
        }
        else {
            return nil
        }
    }

    private func jsonWithType(type: String) -> JSON? {
        for object in self {
            if object.1["type"].string == type {
                return object.1["data"]
            }
        }
        return nil
    }
}
