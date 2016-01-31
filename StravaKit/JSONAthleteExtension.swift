import SwiftyJSON

extension JSON {

    var athlete: Athlete { return Athlete(firstName: self["firstname"].string!, lastName: self["lastname"].string!) }
}
