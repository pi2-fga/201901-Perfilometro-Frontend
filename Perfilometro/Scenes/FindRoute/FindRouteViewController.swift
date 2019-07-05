//
//  FindRouteViewController.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 19/05/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

protocol FindRouteDisplayLogic: class {
  func displaySomething(viewModel: FindRoute.Something.ViewModel)
}

class FindRouteViewController: UIViewController, FindRouteDisplayLogic {
    
    var isPressed: Bool = false
    
    // MARK: - Outlet
    @IBOutlet weak var buttonStart: UIBarButtonItem!
    
    var locationManager = CLLocationManager()
    lazy var mapView = GMSMapView()
    
    // MARK: - Variables
    
    fileprivate var startCoordinate: CLLocationCoordinate2D?
    fileprivate var endCoordinate: CLLocationCoordinate2D?
    

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
//        doSomething()
        
        setupLocationManager()
        setupMapView()
    }

    // MARK: Do something

    func doSomething() {
        let request = FindRoute.Something.Request()
        interactor?.doSomething(request: request)
    }
    @IBAction func controlStateData(_ sender: Any) {
        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Começar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Parar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func displaySomething(viewModel: FindRoute.Something.ViewModel) { }
    

    private func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude:  37.534343434,
                                              longitude: -121.32233232332,
                                              zoom: 13.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        do {
            if let styleURL = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                self.mapView.addSubview(mapView)
            } else { NSLog("Unable to find style.json") }
        } catch { NSLog("One or more of the map styles failed to load. \(error)") }
        
//        self.mapView.addSubview(mapView)
    }
    
    private func setupLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 2.0
        if let startCoordinate = self.startCoordinate {
            self.mapView.animate(toLocation: startCoordinate)
        }
    }
    
    @IBOutlet weak var backgroundView: UIView!
    //    private func createMarkerView() {
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }
}

    

extension FindRouteViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) { }
}

extension FindRouteViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
//        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                              longitude: userLocation!.coordinate.longitude, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        locationManager.stopUpdatingLocation()
    }
}

extension FindRouteViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) { }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) { }
    
    // Turn the network activity indicator on and off again.
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
