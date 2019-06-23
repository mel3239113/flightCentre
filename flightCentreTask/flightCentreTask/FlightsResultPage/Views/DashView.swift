//
//  DashView.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/23/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import UIKit

class DashView: UIView {
    var dashColor: UIColor?
    
    override func layoutSubviews() {
        if let dashColor = dashColor {
            addDashLines(with: dashColor)
        }
    }


}
