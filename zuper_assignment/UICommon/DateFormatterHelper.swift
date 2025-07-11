

import Foundation

struct DateFormatterHelper {
    static func formattedDate(from isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: isoDate) else { return "" }

        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return "Today, " + timeFormatter.string(from: date)
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow, " + timeFormatter.string(from: date)
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday, " + timeFormatter.string(from: date)
        } else {
            return dateFormatter.string(from: date) + ", " + timeFormatter.string(from: date)
        }
    }

    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }

    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }
}

