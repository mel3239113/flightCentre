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
        let sections = presenter.sections()
        XCTAssertEqual(sections, 5)
        
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
