//
//  CalibrateSensorsPresenter.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 14/06/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol CalibrateSensorsPresentationLogic {
    func presentSomething(response: CalibrateSensors.Something.Response)
}

class CalibrateSensorsPresenter: CalibrateSensorsPresentationLogic {
    weak var viewController: CalibrateSensorsViewController?

    // MARK: Do something

    func presentSomething(response: CalibrateSensors.Something.Response) {
//        let viewModel = CalibrateSensors.Something.ViewModel()
//        viewController?.displaySomething(viewModel: viewModel)
    }
}
