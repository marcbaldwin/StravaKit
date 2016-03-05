import Alamofire
import SwiftyJSON

public class Request<T> {

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

public extension Request {

    func onResponse(handler: (Response<T>) -> ()) {
        Alamofire
            .request(method, url, parameters: parameters.build())
            .responseJSON { response in
                switch response.result {
                case .Success(let value):
                    if let response = response.response where response.statusCode == 401 {
                        handler(.Failure(.Unauthorized))
                    } else {
                        handler(.Success(self.transformer(JSON(value))))
                    }

                case .Failure(let error): print(error)
                }
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