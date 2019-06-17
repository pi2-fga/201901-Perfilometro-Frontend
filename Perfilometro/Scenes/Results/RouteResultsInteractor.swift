//
//  RouteResultsInteractor.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 14/06/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol RouteResultsBusinessLogic {
    func doSomething(request: RouteResults.Something.Request)
}

protocol RouteResultsDataStore {
    //var name: String { get set }
}

class RouteResultsInteractor: RouteResultsBusinessLogic, RouteResultsDataStore {
    var presenter: RouteResultsPresentationLogic?
    var worker: RouteResultsWorker?
    //var name: String = ""

    // MARK: Do something

    func doSomething(request: RouteResults.Something.Request) {
        worker = RouteResultsWorker()
        worker?.doSomeWork()

        let response = RouteResults.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
