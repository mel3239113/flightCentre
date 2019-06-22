//
//  Flight.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import Foundation

struct Flight: Codable {
    let id: Int
    let departureDate, airlineCode, flightNumber, departureCity: String
    let departureAirport, arrivalCity, arrivalAirport, scheduledDuration: String
    let arrivalDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case departureDate = "departure_date"
        case airlineCode = "airline_code"
        case flightNumber = "flight_number"
        case departureCity = "departure_city"
        case departureAirport = "departure_airport"
        case arrivalCity = "arrival_city"
        case arrivalAirport = "arrival_airport"
        case scheduledDuration = "scheduled_duration"
        case arrivalDate = "arrival_date"
    }
    
    var readableDuration: String {
        return ""
    }
    
}

extension String {
    
    var displayDay: String {
        return ""
    }
    
    var display12HourTime: String {
        return ""
    }
    
    var display24HourTime: String {
        return ""
    }
    
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.date(from: self)
    }
    
}

typealias Flights = [Flight]
