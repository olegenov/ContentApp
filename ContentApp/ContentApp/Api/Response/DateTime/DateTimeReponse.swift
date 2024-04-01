//
//  DateTimeReponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 30.03.2024.
//

import Foundation

struct DateTimeResponse: Codable {
    let year: Int
    let month: Int
    let day: Int
    let hour: Int
    let minute: Int
    
    func toDate() -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let calendar = Calendar.current
        
        return calendar.date(from: dateComponents)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withFullTime, .withFractionalSeconds, .withTimeZone, .withDashSeparatorInDate, .withColonSeparatorInTime]
        
        if let date = formatter.date(from: dateString) {
            let calendar = Calendar.current
            self.year = calendar.component(.year, from: date)
            self.month = calendar.component(.month, from: date)
            self.day = calendar.component(.day, from: date)
            self.hour = calendar.component(.hour, from: date)
            self.minute = calendar.component(.minute, from: date)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format")
        }
    }
}
