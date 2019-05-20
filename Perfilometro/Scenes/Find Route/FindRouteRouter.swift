//
//  FindRouteRouter.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 19/05/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

@objc protocol FindRouteRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol FindRouteDataPassing {
    var dataStore: FindRouteDataStore? { get }
}

class FindRouteRouter: NSObject, FindRouteRoutingLogic, FindRouteDataPassing {
    weak var viewController: FindRouteViewController?
    var dataStore: FindRouteDataStore?

    // MARK: Routing

    // func routeToSomewhere(segue: UIStoryboardSegue?) {
    //     if let segue = segue {
    //         let destinationVC = segue.destination as! SomewhereViewController
    //         var destinationDS = destinationVC.router!.dataStore!
    //         passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //     } else {
    //         let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //         let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //         var destinationDS = destinationVC.router!.dataStore!
    //         passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //         navigateToSomewhere(source: viewController!, destination: destinationVC)
    //     }
    // }

    // MARK: Navigation

    // func navigateToSomewhere(source: FindRouteViewController, destination: SomewhereViewController) {
    //     source.show(destination, sender: nil)
    // }

    // MARK: Passing data

    // func passDataToSomewhere(source: FindRouteDataStore, destination: inout SomewhereDataStore) {
    //     destination.name = source.name
    // }
}
