import Foundation

class StravaFormatter {

    func formatDate(date: NSDate) -> String {
        let dateFormatter = "d MMMM YYYY".dateFormatter()
        return dateFormatter.stringFromDate(date)
    }

    func formatDistance(distance: Distance) -> String {
        let distanceInKm = distance / 1000
        return "\(distanceInKm.format(1))km"
    }

    func formatElevation(elevation: Distance) -> String {
        return "\(Int(elevation))m"
    }

    func formatSpeed(speed: Speed) -> String {
        let asKmH = speed * Speed(1.hour / 1000)
        return "\(asKmH.format(1))km/h"
    }

    func formatTime(time: Time) -> String {
        let hours = floor(time / 1.hour)
        let minutes = floor((time % 1.hour) / 1.minute)
        let hoursAndMinutes = hours.hours + minutes.minutes
        let seconds = hoursAndMinutes == 0 ? time : time % hoursAndMinutes

        if hours > 0 {
            return "\(Int(hours)):\(Int(minutes).pad(2)):\(Int(seconds).pad(2))"
        }
        else {
            return "\(Int(minutes)):\(Int(seconds).pad(2))"
        }
    }
}