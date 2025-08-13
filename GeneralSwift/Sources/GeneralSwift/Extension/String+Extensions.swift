//
//  String+Extensions.swift
//  GeneralSwift
//
//  Created by ahmed gado on 13/08/2025.
//

import Foundation

public
extension String {
    public func yearOnly() -> String {
        let possibleFormats = ["yyyy-M-d", "yyyy-MM-dd", "yyyy-M-dd", "yyyy-MM-d"]
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        for format in possibleFormats {
            formatter.dateFormat = format
            if let parsedDate = formatter.date(from: self) {
                formatter.dateFormat = "yyyy"
                return formatter.string(from: parsedDate)
            }
        }
        return self
    }
}
