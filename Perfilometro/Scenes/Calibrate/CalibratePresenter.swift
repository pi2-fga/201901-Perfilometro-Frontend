//
//  CalibratePresenter.swift
//  Perfilometro
//
//  Created by Geovanni Oliveira de Jesus on 14/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

protocol CalibratePresentationLogic {
    func presentCalibration(response: CalibrateSensor.CalibrationCases.Response)
}

class CalibratePresenter: CalibratePresentationLogic {
    weak var calibrateViewController: CalibrateDisplayLogic?
    
    func presentCalibration(response: CalibrateSensor.CalibrationCases.Response) {
        let viewModel = CalibrateSensor.CalibrationCases.ViewModel()
        calibrateViewController?.displayCalibration(viewModel: viewModel)
    }
}
