//
//  RouteResultsViewController.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 14/06/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit
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
        self.doSomething()
        setNibUp()
        self.roads?.append(Road(identifier: "00", date: "0000", name: "000000", lazers: [[[0][1]]]))
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

//    func fetchAllRooms(completion: @escaping ([Road]?) -> Void) {
//        guard let url = URL(string: "https://perfilometer-node.herokuapp.com/api/roads") else {
//        completion(nil)
//        return
//        }
//        AF.request(url, method: .get, parameters: nil, headers: ["api-version" : "0.1.0"], interceptor: nil).responseJSON(completionHandler: { (response) in
//            switch response.result {
//            case .success(let result):
//                print("restul: ", result)
//                completion(nil)
//
//
//                if let resulted =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {//result as? [String: Any] {
//
//                    if let data = resulted["data"] as? NSArray {
//                        let roads = data?["roads"]
//                    }
//
//
//                    for road in roads {
//                        if let routeDict = route as? NSDictionary {
//
//
//                        }
//                    }
//
//
//
//                    for route in routes {
//                        if let routeDict = route as? NSDictionary {
//                            let polyline = routeDict["overview_polyline"] as! NSDictionary
//
//
//                        }
//
//                    }
//                }
//
//
//                break
//            case .failure(let error):
//                print(error)
//                completion(nil)
//                break
//            }
//        })
//    }
    
//        guard let value = response.result.value as? [String: Any],
//        let rows = value["rows"] as? [[String: Any]] else {
//        print("Malformed data received from fetchAllRooms service")
//        completion(nil)
//        return
//        }
//
//        let rooms = rows.flatMap { roomDict in return RemoteRoom(jsonData: roomDict) }
//        completion(rooms)
//        }
//        }
    
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
    
    var roads: [Road]?
    
    var road: Road?
    let segueId = "result"
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return roads!.count
    }
    
    private func setNibUp() {
        let agencyNib = UINib.init(nibName: "ResultTableViewCell", bundle: nil)
        self.tableView.register(agencyNib, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultsTableViewCell
        cell.setRoadName(name: roads?[indexPath.row].name ?? "")
        
        
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
        self.road = self.roads?[indexPath.row]
        performSegue(withIdentifier: segueId, sender: nil)
        
    }

}
