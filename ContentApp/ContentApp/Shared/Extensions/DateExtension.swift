//
//  DateExtension.swift
//  ContentApp
//
//  Created by Никита Китаев on 12.04.2024.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy hh:mm"
        
        return formatter.string(from: self)
    }
    
    func toCringe() -> String {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.string(from: self)
    }
}
