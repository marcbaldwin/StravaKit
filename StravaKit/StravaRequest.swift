import Alamofire
import SwiftyJSON

internal class Request {

    static func request<T>(method: Alamofire.Method = .GET, url: String, parameters: Parameters, transformer: (JSON) -> T, handler: (Response<T>) -> ()) {

        Alamofire
            .request(method, url, parameters: parameters.build())
            .responseJSON { response in
                switch response.result {
                case .Success(let value):
                    if let response = response.response where response.statusCode == 401 {
                        handler(.Failure(.Unauthorized))
                    } else {
                        handler(.Success(transformer(JSON(value))))
                    }
                case .Failure(_): handler(.Failure(.Offline))
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