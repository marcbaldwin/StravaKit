
open class StravaClient {

    open var accessToken: String?
    fileprivate let api = StravaApiTemplate()

    public init(accessToken: String? = nil) {
        self.accessToken = accessToken
    }
}

public extension StravaClient { // MARK: Activities

    /// Returns a list of activities within the specified date range for the authenticated user
    func athleteAcitvities(from: Date, to: Date, handler: @escaping (Response<[Activity]>)->Void) {
        if let accessToken = accessToken {
            let parameters = builder(accessToken).add("before", to.timeIntervalSince1970 as AnyObject).add("after", from.timeIntervalSince1970 as AnyObject)
            Request.request(url: api.athleteAcitvities(), parameters: parameters,
                            transformer: { $0.activities }, handler: handler)
        } else {
            handler(.failure(.unauthorized))
        }
    }

    /// Returns a list of activities for the authenticated user
    func athleteAcitvities(page: Int, pageSize: Int, handler: @escaping (Response<[Activity]>)->Void) {
        if let accessToken = accessToken {
            let parameters = builder(accessToken).add("page", page as AnyObject).add("per_page", pageSize as AnyObject)
            Request.request(url: api.athleteAcitvities(), parameters: parameters,
                            transformer: { $0.activities }, handler: handler)
        } else {
            handler(.failure(.unauthorized))
        }
    }

}

public extension StravaClient { // MARK: Activity

    /// Returns the stream of an activity belonging to the authenticated user
    func activityStreamForActivityWithId(_ id: Int, types: [StreamType], handler: @escaping (Response<Stream>)->Void) {
        if let accessToken = accessToken {
            let parameters = builder(accessToken).add("resolution", "low" as AnyObject)
            Request.request(url: api.activityStream(id, types: types), parameters: parameters,
                            transformer: { $0.activityStream }, handler: handler)
        } else {
            handler(.failure(.unauthorized))
        }
    }
}

private extension StravaClient {

    func builder(_ accessToken: String) -> Parameters {
        return Parameters().add("access_token", accessToken as AnyObject)
    }
}
