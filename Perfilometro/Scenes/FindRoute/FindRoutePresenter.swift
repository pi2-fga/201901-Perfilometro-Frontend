//
//  FindRoutePresenter.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 19/05/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol FindRoutePresentationLogic {
    func presentSomething(response: FindRoute.Something.Response)
}

class FindRoutePresenter: FindRoutePresentationLogic {
    weak var viewController: FindRouteDisplayLogic?

    // MARK: Do something

    func presentSomething(response: FindRoute.Something.Response) {
        let viewModel = FindRoute.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
