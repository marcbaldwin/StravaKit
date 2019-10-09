public struct Map: Codable, Equatable {

    public let id: String
    public let polyline: String?
    public let summaryPolyline: String?

    enum CodingKeys : String, CodingKey {
        case id
        case polyline
        case summaryPolyline = "summary_polyline"
    }
}
