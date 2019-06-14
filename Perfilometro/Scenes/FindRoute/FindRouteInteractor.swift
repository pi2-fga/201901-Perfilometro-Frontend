//
//  FindRouteInteractor.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 19/05/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol FindRouteBusinessLogic {
    func doSomething(request: FindRoute.Something.Request)
}

protocol FindRouteDataStore {
    //var name: String { get set }
}

class FindRouteInteractor: FindRouteBusinessLogic, FindRouteDataStore {
    var presenter: FindRoutePresentationLogic?
    var worker: FindRouteWorker?
    //var name: String = ""

    // MARK: Do something

    func doSomething(request: FindRoute.Something.Request) {
        worker = FindRouteWorker()
        worker?.doSomeWork()

        let response = FindRoute.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
