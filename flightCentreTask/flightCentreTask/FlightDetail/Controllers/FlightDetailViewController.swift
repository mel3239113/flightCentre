//
//  FlightDetailViewController.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/23/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import UIKit

class FlightDetailViewController: UIViewController {
    @IBOutlet weak var dashLine: DashView!
    
    @IBOutlet weak var airportDepartureLabel: UILabel!
    @IBOutlet weak var cityDepartureLabel: UILabel!
    @IBOutlet weak var dayDepartureLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    
    @IBOutlet weak var airportArrival: UILabel!
    @IBOutlet weak var cityArrivalLabel: UILabel!
    @IBOutlet weak var dayArrivalLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    @IBOutlet weak var flightCodeLabel: UILabel!
    
    let presenter: FlightDetailPresenter = FlightDetailPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flight = presenter.flight {
            airportDepartureLabel.text = flight.departureAirport
            cityDepartureLabel.text = flight.flightPoint(details: .departure, location: .city)
            dayDepartureLabel.text = flight.departureDate.displayDateString(for: .displayDay)
            departureTimeLabel.text = flight.departureDate.displayDateString(for: .tweleHourTime)
            
            airportArrival.text = flight.arrivalAirport
            cityArrivalLabel.text = flight.flightPoint(details: .arrival, location: .city)
            dayArrivalLabel.text = flight.arrivalDate.displayDateString(for: .displayDay)
            arrivalTimeLabel.text = flight.arrivalDate.displayDateString(for: .tweleHourTime)
            
            flightCodeLabel.text = flight.flightCode
        }
    }
    


}
