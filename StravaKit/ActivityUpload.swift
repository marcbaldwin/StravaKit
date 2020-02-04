public struct ActivityUpload: Equatable, Hashable {

    public let externalId: String
    public let activityType: String
    public let url: URL
    public let fileName: String
    public let dataType: String
    public let mimeType: String

    public init(
        externalId: String,
        activityType: String,
        url: URL,
        fileName: String,
        dataType: String,
        mimeType: String
    ) {
        self.externalId = externalId
        self.activityType = activityType
        self.url = url
        self.fileName = fileName
        self.dataType = dataType
        self.mimeType = mimeType
    }
}
