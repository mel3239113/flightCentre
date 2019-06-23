//
//  View-extensions.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/23/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addDashLines(with color: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineDashPattern = [2,4]
    
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)])

        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
        
    }
}
