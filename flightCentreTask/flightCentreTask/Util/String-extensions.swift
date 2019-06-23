//
//  String-extensions.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import Foundation

enum TimeFormat: String {
    case displayDayAndMonth = "E, dd MMMM"
    case displayDay = "E, dd MMM"
    case tweleHourTime = "hh:mm a"
    case twentyFourHourTime = "HH:mm"
    case yearMonthDay = "yyyy-MM-dd"
}
//
extension String {
    
    func displayDateString(for format: TimeFormat) -> String? {
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  format.rawValue
        return dateFormatter.string(from: date)
    }
    
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.date(from: self)
    }
    
    var simpleDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
}
