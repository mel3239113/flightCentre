//
//  Flight.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import Foundation

typealias Flights = [Flight]

enum FlightPointType {
    case arrival
    case departure
}

enum LocationType {
    case city
    case country
}

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
    
    var isInternationl: Bool {
        if flightPoint(details: .arrival, location: .country) == flightPoint(details: .departure, location: .country) {
            return false
        }
        return true
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
    
    func flightPoint(details flightPoint: FlightPointType, location: LocationType) -> String {
        var point: String
        switch flightPoint {
        case .arrival: point = arrivalCity
        case .departure: point = departureCity
        }
        let cityAndCountry = point.components(separatedBy: ", ")
        
        switch location {
        case .city: return cityAndCountry[0]
        case .country: return cityAndCountry[1]
        }
    }
}
