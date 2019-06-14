//
//  RouteProfileInteractor.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 14/06/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol RouteProfileBusinessLogic {
    func doSomething(request: RouteProfile.Something.Request)
}

protocol RouteProfileDataStore {
    //var name: String { get set }
}

class RouteProfileInteractor: RouteProfileBusinessLogic, RouteProfileDataStore {
    var presenter: RouteProfilePresentationLogic?
    var worker: RouteProfileWorker?
    //var name: String = ""

    // MARK: Do something

    func doSomething(request: RouteProfile.Something.Request) {
        worker = RouteProfileWorker()
        worker?.doSomeWork()

        let response = RouteProfile.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
