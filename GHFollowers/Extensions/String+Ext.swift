//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 26.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import Foundation

extension String {
    public func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    public func convertToDisplayFormat() -> String {
        guard  let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
