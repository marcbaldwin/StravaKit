import SwiftyJSON

extension JSON {

    var activityStream: Stream {

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

        return dataPoints
    }

    fileprivate func dataArray(_ name: String) -> [AnyObject]? {
        let rawArray = jsonWithType(name)
        return rawArray?.arrayObject as [AnyObject]?
    }

    fileprivate func coodinates() -> [Coordinate]? {
        return jsonWithType("latlng")?.coordinates
    }

    fileprivate func jsonWithType(_ type: String) -> JSON? {
        for object in self {
            if object.1["type"].string == type {
                return object.1["data"]
            }
        }
        return nil
    }
}
