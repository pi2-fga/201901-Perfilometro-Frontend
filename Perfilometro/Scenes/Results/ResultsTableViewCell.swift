//
//  ResultsTableViewCell.swift
//  Perfilometro
//
//  Created by Geovanni Oliveira de Jesus on 14/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit
import MapKit

class ResultsTableViewCell: UITableViewCell, MKMapViewDelegate {
    
    // MARK :- Outlet
    
    @IBOutlet weak var roadName: UILabel!
    @IBOutlet weak var tracedRoute: MKMapView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Variables
    
    var mapDeparture: String = "" {
        didSet {
             self.roadName.text = mapDeparture
        }
    }
    
    var name: String = "" {
        didSet {
            roadName.text = name
        }
    }
    
    var date: String = "" {
        didSet {
            self.dateLabel.text = date
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setup(road: Road) {
        self.name = road.name
        if let formattedDate = setFormattedDate(date: road.date) {
            self.date = formattedDate.asString(style: .long)
        }
        
        let initialPoint = CLLocationCoordinate2D(latitude: -15.989117, longitude: -48.045396)
        let finalPoint = CLLocationCoordinate2D(latitude: -16.021111, longitude: -48.061977)
        
        showRouteOnMap(pickupCoordinate: initialPoint, destinationCoordinate: finalPoint)
    }
   
    private func setupLayout() {
        self.tracedRoute.delegate = self
        self.tracedRoute.layer.cornerRadius = 10
    }
    

    private func setFormattedDate(date: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate,
                                   .withTime,
                                   .withDashSeparatorInDate,
                                   .withColonSeparatorInTime]
        
        return formatter.date(from: date)
    }
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let sourcePlacemark = MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.tracedRoute.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            
            self.tracedRoute.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.tracedRoute.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(named: "primaryBlue")
        renderer.lineWidth = 3.0
        
        return renderer
    }
}
