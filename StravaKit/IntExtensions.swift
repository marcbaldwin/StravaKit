import Foundation

extension Int {

    var hour: TimeInterval { return self.hours }
    var hours: TimeInterval { return TimeInterval(self * 60 * 60) }
    var minute: TimeInterval { return self.minutes }
    var minutes: TimeInterval { return TimeInterval(self * 60) }
}
