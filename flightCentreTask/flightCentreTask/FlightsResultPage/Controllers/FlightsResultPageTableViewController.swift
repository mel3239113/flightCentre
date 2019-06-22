//
//  FlightsResultPageTableViewController.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import UIKit

protocol FlightSearchUpdateable: class {
    func didRecieveFlights()
}

class FlightsResultPageTableViewController: UITableViewController {
    
    //inject the flight service to keep it modula incase services change and allows mocking in tests
    var presenter: FlightsResultPresenter = FlightsPresenter(flightService: FlightService.shared)
    
    override func viewDidLoad() {
        let nib = UINib(nibName: FlightTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FlightTableViewCell.identifier)
        super.viewDidLoad()
        presenter.loadFlights()
        
        //We only do the cast here to assign a delegate apart from that we only want the vc knowing about
        //funtionality exposed by the protocols
        if let concretePresenter = presenter as? FlightsPresenter {
            concretePresenter.delegate = self
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.count(for: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.flightSection(at: section).displayDate
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightTableViewCell.identifier, for: indexPath) as? FlightTableViewCell else { fatalError("You need to register FlightTableViewCell")}
        
        let flight = presenter.flight(at: indexPath.section, for: indexPath.row)
        cell.textLabel?.text = flight.readableDuration
        return cell
    }
}

extension FlightsResultPageTableViewController: FlightSearchUpdateable {
    func didRecieveFlights() {
        tableView.reloadData()
    }
}
