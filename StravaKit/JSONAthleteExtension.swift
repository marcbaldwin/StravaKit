import SwiftyJSON

extension JSON {

    var athlete: Athlete? {
        guard
            let firstName = self["firstname"].string,
            let lastName = self["lastname"].string,
            let premium = self["premium"].bool,
            let measurementPreference = self["measurement_preference"].measurementPreference
        else { return nil }

        let username = self["username"].string
        let email = self["email"].string

        return Athlete(username: username, email: email,
                       firstName: firstName, lastName: lastName,
                       premium: premium,
                       measurementPreference: measurementPreference)
    }
}

extension JSON {

    var measurementPreference: MeasurementPreference? {
        guard let value = string else { return nil }
        if value == "meters" {
            return .Meters
        } else {
            return .Feet
        }
    }
}