import CoreLocation
import SwiftyJSON

extension JSON {

    public var coordinates: [CLLocationCoordinate2D] {
        return array!.map { $0.coordinate }
    }

    public var coordinate: CLLocationCoordinate2D {
        let latitudeLongitude = arrayObject!
        let latitude = (latitudeLongitude[0] as AnyObject).doubleValue!
        let longitude = (latitudeLongitude[1] as AnyObject).doubleValue!
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
