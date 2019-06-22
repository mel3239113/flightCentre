//
//  FlightsResultPagePresenter.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import Foundation

protocol FlightsResultPresenter {
    func loadFlights()
    func sections(for flights: [Flight]) -> Int

}

class FlightsPresenter: FlightsResultPresenter {
    private let flightService: FlightSearchService
    private var flights: Flights = []

    
    init (flightService: FlightSearchService) {
        self.flightService = flightService
    }
    
    func loadFlights() {
        guard let url = URL(string: Constants.flightEndPoint) else { return }
        
        flightService.request(from: url) { [weak self] (result: Result<Flights, Error>) in
            switch result {
            case .success(let flights):
                self?.flights = flights
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sections() -> Int {
        
        return 0
    }
}
