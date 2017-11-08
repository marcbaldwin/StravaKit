
public struct Map: Codable {

    public let id: String
    public let polyline: String?
    public let summaryPolyline: String?

    enum CodingKeys : String, CodingKey {
        case id
        case polyline
        case summaryPolyline = "summary_polyline"
    }
}

extension Map: Equatable {

    public static func ==(lhs: Map, rhs: Map) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.polyline == rhs.polyline &&
            lhs.summaryPolyline == rhs.summaryPolyline
    }
}
