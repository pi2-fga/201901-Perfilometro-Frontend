//
//  RouteProfilePresenter.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 14/06/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol RouteProfilePresentationLogic {
    func presentSomething(response: RouteProfile.Something.Response)
}

class RouteProfilePresenter: RouteProfilePresentationLogic {
    weak var viewController: RouteProfileDisplayLogic?

    // MARK: Do something

    func presentSomething(response: RouteProfile.Something.Response) {
        let viewModel = RouteProfile.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
