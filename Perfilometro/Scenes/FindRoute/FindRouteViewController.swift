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
    
    // MARK: - Outlet
    var reportBtn: UIButton!
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!// = GMSMapView()
    var camera: GMSCameraPosition!
    lazy var mqtt_manager = MQTT_Manager()
    
    lazy var reportCenterX = reportBtn.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor)
    lazy var reportWidth = reportBtn.widthAnchor.constraint(equalToConstant: 366)
    lazy var reportHeight = reportBtn.heightAnchor.constraint(equalToConstant: 122)
    
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

    override func loadView() {
        setupMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        doSomething()
//        setupMapView()
        setReportBtn()
        setupLocationManager()
        
        
    }

    // MARK: Do something

    func doSomething() {
        let request = FindRoute.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: FindRoute.Something.ViewModel) { }
    

    private func setupMapView() {

        camera = GMSCameraPosition.camera(withLatitude:  37.534343434,
                                              longitude: -121.32233232332,
                                              zoom: 13.0)
        mapView = GMSMapView(frame: .zero)
        mapView.isMyLocationEnabled = true
        mapView.camera = camera
        mapView.delegate = self
        view = mapView
        
        
        
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.isMyLocationEnabled = true
//        mapView.delegate = self
//
//        do {
//            if let styleURL = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
//                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
//                self.mapView.addSubview(mapView)
//            } else { NSLog("Unable to find style.json") }
//        } catch { NSLog("One or more of the map styles failed to load. \(error)") }
        
//        self.mapView.addSubview(mapView)
    }
    
    private func setupLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 2.0
        if let startCoordinate = self.startCoordinate {
            self.mapView.animate(toLocation: startCoordinate)
        }
    }
    
//    private func createMarkerView() {
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }
    func setReportBtn() {
        
        reportBtn = UIButton(type: .custom)
        reportBtn.setImage(UIImage(named: "startBtn"), for: .normal)
        reportBtn.addTarget(self, action: #selector(startPressed(sender:)), for: .touchUpInside)
        reportBtn.contentMode = .scaleAspectFit
        
        self.mapView.addSubview(reportBtn)
        
        let margins = self.mapView.layoutMarginsGuide
       
        reportBtn.translatesAutoresizingMaskIntoConstraints = false
        self.reportWidth.isActive = true
        self.reportHeight.isActive = true
        reportBtn.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -30).isActive = true
        self.reportCenterX.isActive = true
    }
    
    @objc func startPressed(sender: UIButton!) {
        mqtt_manager.turnSensorsOn()
    }
    
    @objc func finishPressed(sender: UIButton!) {
        mqtt_manager.turnSensorsOff()
    }
}

    

extension FindRouteViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
    }
}

extension FindRouteViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
//        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                              longitude: userLocation!.coordinate.longitude, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
//        self.view = mapView
        
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
