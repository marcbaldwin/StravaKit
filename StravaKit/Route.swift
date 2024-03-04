public struct Route: Codable, Equatable, Hashable, Identifiable {
    public let id: Int64
    public let name: String
    public let description: String?
    public let map: Map
}
