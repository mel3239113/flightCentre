//
//  FlightResultsViewController.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import UIKit

protocol FlightSearchUpdateable: class {
    func didRecieveFlights()
}
class FlightResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    var presenter: FlightsResultPresenter = FlightsPresenter(flightService: FlightService.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: FlightTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FlightTableViewCell.identifier)

        self.tableView.separatorColor = Constants.Colors.tableViewBackgroundGrey
        
    
        //We only do the cast here to assign a delegate apart from that we only want the vc knowing about
        //funtionality exposed by the protocols
        if let concretePresenter = presenter as? FlightsPresenter {
            concretePresenter.delegate = self
        }
        // Do any additional setup after loading the view.
        activityView.startAnimating()
        presenter.loadFlights()

    }

}

extension FlightResultsViewController: UITableViewDelegate {
    
}

extension FlightResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightTableViewCell.identifier, for: indexPath) as! FlightTableViewCell
            cell.update(with: presenter.flight(at: indexPath.section, for: indexPath.row))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.count(for: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.flightSection(at: section).displayDate
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        view.backgroundColor = Constants.Colors.tableViewBackgroundGrey
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        dateLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        dateLabel.textColor = Constants.Colors.flightCentreGrey
        dateLabel.backgroundColor = Constants.Colors.tableViewBackgroundGrey
        let headerView = UIView()
        headerView.backgroundColor = Constants.Colors.tableViewBackgroundGrey
        headerView.addSubview(dateLabel)
        return headerView
    }
}

extension FlightResultsViewController: FlightSearchUpdateable {
    func didRecieveFlights() {
        activityView.stopAnimating()
        tableView.reloadData()
    }
}

