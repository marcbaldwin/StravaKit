
public struct Route: Codable {

    public let id: Int
    public let name: String
    public let description: String
    public let map: Map
}

extension Route: Equatable {

    public static func ==(lhs: Route, rhs: Route) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.description == rhs.description &&
            lhs.map == rhs.map
    }
}
