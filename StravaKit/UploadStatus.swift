
public struct UploadStatus: Codable, Equatable {

    public let id: Int
    public let externalId: String
    public let error: String?
    public let status: String
    public let activityId: Int?

    enum CodingKeys : String, CodingKey {
        case id
        case externalId = "external_id"
        case error
        case status
        case activityId = "activity_id"
    }
}
