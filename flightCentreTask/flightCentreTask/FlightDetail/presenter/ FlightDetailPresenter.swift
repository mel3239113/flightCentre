//
//   FlightDetailPresenter.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/23/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import Foundation

class FlightDetailPresenter {
    private (set)var flight: Flight?
    
    func load(flight: Flight) {
        self.flight = flight
    }
}
