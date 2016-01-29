import Foundation

extension Int {

    var hour: NSTimeInterval { return self.hours }
    var hours: NSTimeInterval { return NSTimeInterval(self * 60 * 60) }
    var minute: NSTimeInterval { return self.minutes }
    var minutes: NSTimeInterval { return NSTimeInterval(self * 60) }
}