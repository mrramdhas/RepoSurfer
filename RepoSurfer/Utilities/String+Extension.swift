//
//  Date+Extension.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-06.
//

import Foundation

extension String {
    func toReadableDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: Date())
            
            if let years = components.year, years > 0 {
                dateFormatter.dateFormat = "MMM d, yyyy"
                return dateFormatter.string(from: date)
            } else if let months = components.month, months > 0 {
                dateFormatter.dateFormat = "MMM d, yyyy"
                return dateFormatter.string(from: date)
            } else if let days = components.day, days > 0 {
                dateFormatter.dateFormat = "MMM d, yyyy"
                return dateFormatter.string(from: date)
            } else if let hours = components.hour, hours > 0 {
                return "\(hours) hour\(hours == 1 ? "" : "s") ago"
            } else if let minutes = components.minute, minutes > 0 {
                return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
            } else {
                return "Just now"
            }
        }
        
        return ""
    }
}
