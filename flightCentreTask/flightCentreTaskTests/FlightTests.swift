//
//  FlightTests.swift
//  flightCentreTaskTests
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import XCTest
@testable import flightCentreTask

class FlightTests: XCTestCase {
    
    let flight = Flight(id: 9, departureDate: "2018-01-01T21:45:00.000", airlineCode: "AC", flightNumber: "8125", departureCity: "Vancouver, Canada", departureAirport: "YVR", arrivalCity: "Portland, United States", arrivalAirport: "PDX", scheduledDuration: "1hr11min", arrivalDate: "2018-01-01T22:56:00.000")
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testParsingStringToDate() {
        XCTAssertNotNil(flight.departureDate.date)
    }
    
    func testFlightReadableDayDate() {
        XCTAssertEqual(flight.departureDate.displayDay, "Sat 01 Jan")
    }
    
    func testFlightReadable12HourTime() {
        XCTAssertEqual(flight.departureDate.display12HourTime, "09:45 PM")
    }
    
    func testFlightReadable24HourTime() {
        XCTAssertEqual(flight.departureDate.display24HourTime, "21:45")

    }
    
    func flighTestReadableDuration() {
        XCTAssertEqual(flight.readableDuration,"1 hr 11 min" )
    }


}
