//
//  FindRouteViewController.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 19/05/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol FindRouteDisplayLogic: class {
  func displaySomething(viewModel: FindRoute.Something.ViewModel)
}

class FindRouteViewController: UIViewController, FindRouteDisplayLogic {
    var interactor: FindRouteBusinessLogic?
    var router: (NSObjectProtocol & FindRouteRoutingLogic & FindRouteDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = FindRouteInteractor()
        let presenter = FindRoutePresenter()
        let router = FindRouteRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func doSomething() {
        let request = FindRoute.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: FindRoute.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
