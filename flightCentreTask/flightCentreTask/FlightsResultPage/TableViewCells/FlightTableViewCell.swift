//
//  FlightTableViewCell.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    static let identifier: String = "FlightTableViewCell"

    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var destinationCityLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var planeImage: UIImageView!
    @IBOutlet weak var departDetails: FlightPoint!
    @IBOutlet weak var arrivalDetails: FlightPoint!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        planeImage.image = planeImage.image?.withRenderingMode(.alwaysTemplate)
        planeImage.tintColor = Constants.Colors.flightCentreBlue
        // Initialization code
    }
    
    func update(with flight: Flight) {
        
        departDetails.airportLabel.text = flight.departureAirport
        departDetails.cityLabel.text = flight.flightPoint(details: .departure, location: .city)
        departDetails.timeLabel.text = flight.departureDate.displayDateString(for: .twentyFourHourTime)
        
        arrivalDetails.airportLabel.text = flight.arrivalAirport
        arrivalDetails.cityLabel.text = flight.flightPoint(details: .arrival, location: .city)
        arrivalDetails.timeLabel.text = flight.arrivalDate.displayDateString(for: .twentyFourHourTime)
        
        if flight.isInternationl {
            destinationCityLabel.text = "Flight To \(flight.flightPoint(details: .arrival, location: .country))"
        }else{
            destinationCityLabel.text = "Flight To \(flight.flightPoint(details: .arrival, location: .city))"
        }
        
        durationLabel.text = flight.readableDuration
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
