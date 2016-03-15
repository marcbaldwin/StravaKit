import Alamofire
import SwiftyJSON

internal class Request<T> {

    private let method: Alamofire.Method
    private let url: String
    private let parameters: Parameters
    private let transformer: (JSON) -> T

    init(method: Alamofire.Method = .GET, url: String, parameters: Parameters, transformer: (JSON) -> T) {
        self.method = method
        self.url = url
        self.parameters = parameters
        self.transformer = transformer
    }
}

internal extension Request {

    func onResponse(handler: (Response<T>) -> ()) {

        let responseHandler: (Alamofire.Response<AnyObject, NSError>)->Void = { response in
            switch response.result {
            case .Success(let value):
                if let response = response.response where response.statusCode == 401 {
                    handler(.Failure(.Unauthorized))
                } else {
                    handler(.Success(self.transformer(JSON(value))))
                }
            case .Failure(let error): self.handleError(error, handler: handler)
            }
        }

        Alamofire
            .request(method, url, parameters: parameters.build())
            .responseJSON(completionHandler: responseHandler)
    }

    func handleError(error: NSError, handler: (Response<T>) -> ()) {
        if 1009 == error.code {
            handler(.Failure(.Offline))
        }
    }
}

internal class Parameters {
    private var parameters = [String : AnyObject]()

    func add(key: String, _ value: AnyObject) -> Self {
        parameters[key] = value
        return self
    }

    func build() -> [String : AnyObject] {
        return parameters
    }
}