//
//  CalibrateViewController.swift
//  Perfilometro
//
//  Created by Geovanni Oliveira de Jesus on 14/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import UIKit

protocol CalibrateDisplayLogic: class {
    func displayCalibration(viewModel: CalibrateSensor.CalibrationCases.ViewModel)
}

class CalibrationViewController: UIViewController, CalibrateDisplayLogic {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func displayCalibration(viewModel: CalibrateSensor.CalibrationCases.ViewModel) {
        
    }
}
