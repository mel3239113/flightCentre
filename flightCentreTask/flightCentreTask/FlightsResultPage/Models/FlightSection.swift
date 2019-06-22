//
//  FlightSections.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import Foundation

struct FlightSection {
    var flights: [Flight]
    let dayDateString: String
    
    var displayDate: String {
        return flights.first?.departureDate.displayDateString(for: .displayDayAndMonth) ?? ""
    }
    
    init(flights: [Flight], dayDateString: String) {
        self.flights = []
        self.dayDateString = dayDateString
        self.flights = ordered(unorderFlights: flights)
    }
    
    var timestamp: Double {
        return dayDateString.simpleDate?.timeIntervalSince1970 ?? 0
    }
    
    func ordered(unorderFlights: [Flight]) -> [Flight] {
        let flights = unorderFlights.sorted(by: { (f1, f2) -> Bool in
            if let dateOne = f1.departureDate.date, let dateTwo = f2.departureDate.date {
                return dateOne.timeIntervalSince1970 < dateTwo.timeIntervalSince1970
            }
            return false
        })
        return flights
    }
}
