//
//  CalibrateInteractor.swift
//  Perfilometro
//
//  Created by Geovanni Oliveira de Jesus on 14/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

protocol CalibrateBusinessLogic {
    func doSomething(request: CalibrateSensor.CalibrationCases.Request)
}

protocol CalibrateDataStore {
    
}

class CalibrateInteractor: CalibrateBusinessLogic {
    weak var presenter: CalibratePresenter?
    weak var worker: CalibrateWorker?
    
    func doSomething(request: CalibrateSensor.CalibrationCases.Request) {
        worker = CalibrateWorker()
        
        let response = CalibrateSensor.CalibrationCases.Response()
        presenter?.presentCalibration(response: response)
    }
}
