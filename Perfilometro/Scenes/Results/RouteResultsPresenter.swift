//
//  RouteResultsPresenter.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 14/06/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol RouteResultsPresentationLogic {
    func presentSomething(response: RouteResults.Something.Response)
}

class RouteResultsPresenter: RouteResultsPresentationLogic {
    weak var viewController: RouteResultsDisplayLogic?

    // MARK: Do something

    func presentSomething(response: RouteResults.Something.Response) {
        let viewModel = RouteResults.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
