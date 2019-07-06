//
//  RouteResultsViewController.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 14/06/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

protocol RouteResultsDisplayLogic: class {
  func displaySomething(viewModel: RouteResults.Something.ViewModel)
}

class RouteResultsViewController: UITableViewController, RouteResultsDisplayLogic {
    var interactor: RouteResultsBusinessLogic?
    var router: (NSObjectProtocol & RouteResultsRoutingLogic & RouteResultsDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Variable
    
    var roads = [Road]()

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = RouteResultsInteractor()
        let presenter = RouteResultsPresenter()
        let router = RouteResultsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.doSomething()
        setNibUp()
        getRoads()
    }

    // MARK: Do something
    
    private func getRoads() {
        NetworkManager.shared.request(endpoint: RoadEnpoint.getRoads) { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let content = json["data"]
                for item in content["roads"].arrayValue {
                    let road = Road(from: item)
                    self.roads.append(road)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            case .failure(let error):
                print(error)
            }

        }
    }

    func doSomething() {
//        self.fetchAllRooms { (roads) in
//            print("roads", roads)
//        }
        let request = RouteResults.Something.Request()
//        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: RouteResults.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
//    var roads: [Road]?
    
    var road: Road?
    let segueId = "result"
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return roads.count }
    
    private func setNibUp() {
        let agencyNib = UINib.init(nibName: "ResultTableViewCell", bundle: nil)
        self.tableView.register(agencyNib, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultsTableViewCell
        cell.setup(road: roads[indexPath.row])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            let singleResultView: SingleResultsTableViewController = segue.destination as! SingleResultsTableViewController
            singleResultView.roadname = self.road
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: segueId, sender: nil)
    }

}
