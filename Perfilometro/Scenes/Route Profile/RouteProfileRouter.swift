//
//  RouteProfileRouter.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 14/06/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

@objc protocol RouteProfileRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol RouteProfileDataPassing {
    var dataStore: RouteProfileDataStore? { get }
}

class RouteProfileRouter: NSObject, RouteProfileRoutingLogic, RouteProfileDataPassing {
    weak var viewController: RouteProfileViewController?
    var dataStore: RouteProfileDataStore?

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

    // func navigateToSomewhere(source: RouteProfileViewController, destination: SomewhereViewController) {
    //     source.show(destination, sender: nil)
    // }

    // MARK: Passing data

    // func passDataToSomewhere(source: RouteProfileDataStore, destination: inout SomewhereDataStore) {
    //     destination.name = source.name
    // }
}
