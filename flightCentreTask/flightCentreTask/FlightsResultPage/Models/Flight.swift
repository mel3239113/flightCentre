//
//  Flight.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import Foundation

typealias Flights = [Flight]
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
    
    var departDayMonthYear: String {
        return departureDate.displayDateString(for: .yearMonthDay) ?? ""
    }
    var readableDuration: String {
        var readableString: String = scheduledDuration
        let hours = "hr"
        let mins = "min"
        
        if let hoursRange = readableString.range(of: hours) {
            readableString.insert(" ", at: hoursRange.lowerBound)
        }
        if let hoursRange = readableString.range(of: hours) {
            readableString.insert(" ", at: hoursRange.upperBound)
        }
        if let minsRange =  readableString.range(of: mins) {
            readableString.insert(" ", at: minsRange.lowerBound)
        }
        return readableString
    }
}
