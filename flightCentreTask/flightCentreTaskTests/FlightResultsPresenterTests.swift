//
//  FlightResultsPresenterTests.swift
//  flightCentreTaskTests
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import XCTest
@testable import flightCentreTask

class FlightResultsPresenterTests: XCTestCase {
    var presenter: FlightsPresenter!
    var flights: [Flight] = []
    override func setUp() {
        let mockFlightSearchService = MockFlightService()
        presenter = FlightsPresenter(flightService: mockFlightSearchService)
    }
    
    func testCalculateSectionCount() {
        presenter.loadFlights()
        XCTAssertEqual(presenter.sections, 15)
        
    }
    
    func testSegmentFlightsIntoSections() {
        presenter.loadFlights()
        let flights =  presenter.findFlights(with: "2018-01-01")
        XCTAssertEqual(flights.count, 3)
    }
    
    func testFlightSectionsSorting() {
        let flightSectionOne = FlightSection(flights: [], dayDateString: "2018-12-10")
        let flightSectionTwo = FlightSection(flights: [], dayDateString: "2018-12-11")
        let flightSectionThree = FlightSection(flights: [], dayDateString: "2018-12-12")
        let flightSections: [FlightSection] = [flightSectionTwo, flightSectionOne, flightSectionThree ]
        
        let orderSections = presenter.ordered(unorderFlightSections: flightSections)
        XCTAssertEqual(orderSections[0].dayDateString, "2018-12-10")
    }
    
    func testFlightsOrderedInSection() {
        
    }
}

struct MockFlightService: FlightSearchService {
    func request<Flights: Codable>(from endPoint: URL, completionHandler: @escaping (Result<Flights, Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "MockFlightResults", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let flights = try! JSONDecoder().decode(Flights.self, from: data)
            completionHandler(.success(flights))
        }
      
    }
    
    
    
    
}
