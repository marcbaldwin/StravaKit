import Foundation
import SwiftyJSON

extension JSON {

    var athlete: Athlete {

        let athlete = Athlete()

        athlete.firstName = self["firstname"].string
        athlete.lastName = self["lastname"].string

        return athlete
    }
}
