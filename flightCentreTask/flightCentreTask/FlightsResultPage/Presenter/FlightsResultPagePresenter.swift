//
//  FlightsResultPagePresenter.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import Foundation

protocol FlightsResultPresenter: class {
    func loadFlights()
    func count(for section: Int) -> Int
    func flightSection(at section: Int) -> FlightSection
    func flight(at section: Int, for row: Int) -> Flight
    var sections: Int { get }
    
    
}

class FlightsPresenter: FlightsResultPresenter {
    
    private let flightService: FlightSearchService
    private var flights: Flights = []
    private var flightSections: [FlightSection] = []
    weak var delegate: FlightSearchUpdateable?

    //find out how many unique dates with have
    private var uniqueDates: Set<String> {
        var localSet: Set<String> = []
        for flight in flights {
            localSet.insert(flight.departDayMonthYear)
        }
        return localSet
    }
    
    var sections: Int {
        return flightSections.count
    }
    
    
    init (flightService: FlightSearchService) {
        self.flightService = flightService
    }
    
    func count(for section: Int) -> Int {
        return flightSections[section].flights.count
    }
    
    func flightSection(at section: Int) -> FlightSection {
        return flightSections[section]
    }
    
    func flight(at section: Int, for row: Int) -> Flight {
        let section = flightSection(at: section)
        return section.flights[row]
    }
    
    func loadFlights() {
        guard let url = URL(string: Constants.flightEndPoint) else { return }
        
        flightService.request(from: url) { [weak self] (result: Result<Flights, Error>) in
            switch result {
            case .success(let flights):
                self?.flights = flights
                self?.buildFlightSections()
                self?.delegate?.didRecieveFlights()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func buildFlightSections() {
        //build sections with dates
        for dayTag in uniqueDates {
            let flights = findFlights(with: dayTag)
            let flightSection = FlightSection(flights: flights, dayDateString: dayTag)
            flightSections.append(flightSection)
        }
        flightSections = ordered(unorderFlightSections: flightSections)
    }
    
     func findFlights(with departDayMonthYear: String) -> [Flight] {
        let filteredFlights = self.flights.filter { (f1) -> Bool in
            return f1.departDayMonthYear == departDayMonthYear
        }
        return filteredFlights
    }
    
    func ordered(unorderFlightSections: [FlightSection]) -> [FlightSection] {
        let flightSections = unorderFlightSections.sorted(by: { (f1, f2) -> Bool in
            return f1.timestamp < f2.timestamp
        })
        return flightSections
    }
 
}
