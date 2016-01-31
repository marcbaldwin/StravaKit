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

    func onSuccess(handler: (T) -> ()) {
        Alamofire.request(method, url, parameters: parameters.build()).responseJSON { response in
            if let error = response.result.error {
                print(error)
            }
            else {
                handler(self.transformer(JSON(response.result.value!)))
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