//
//  CalibrateSensorsInteractor.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 14/06/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol CalibrateSensorsBusinessLogic {
    func doSomething(request: CalibrateSensors.Something.Request)
}

protocol CalibrateSensorsDataStore {
    //var name: String { get set }
}

class CalibrateSensorsInteractor: CalibrateSensorsBusinessLogic, CalibrateSensorsDataStore {
    var presenter: CalibrateSensorsPresentationLogic?
    var worker: CalibrateSensorsWorker?
    //var name: String = ""

    // MARK: Do something

    func doSomething(request: CalibrateSensors.Something.Request) {
        worker = CalibrateSensorsWorker()
        worker?.doSomeWork()

        let response = CalibrateSensors.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
