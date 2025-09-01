import Foundation

struct NotificationData {
    let title: String
    let startTime: Date
    let endTime: Date
    let location: String?
    let timeUntilStart: TimeInterval
    
    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return "\(formatter.string(from: startTime))–\(formatter.string(from: endTime))"
    }
    
    var countdownText: String {
        let seconds = Int(timeUntilStart)
        if seconds > 60 {
            let minutes = seconds / 60
            return "The event will start in \(minutes) minute\(minutes == 1 ? "" : "s")"
        } else {
            return "The event will start in \(seconds) second\(seconds == 1 ? "" : "s")"
        }
    }
}

enum SnoozeOption {
    case oneMinute
    case fiveMinutes
    case untilEvent
    
    var title: String {
        switch self {
        case .oneMinute: return "1 minute"
        case .fiveMinutes: return "5 minutes"
        case .untilEvent: return "Until Event"
        }
    }
    
    var duration: TimeInterval {
        switch self {
        case .oneMinute: return 60
        case .fiveMinutes: return 300
        case .untilEvent: return 0 // Will be calculated based on event time
        }
    }
}