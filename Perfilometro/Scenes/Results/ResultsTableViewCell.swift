//
//  ResultsTableViewCell.swift
//  Perfilometro
//
//  Created by Geovanni Oliveira de Jesus on 14/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit
import MapKit

class ResultsTableViewCell: UITableViewCell {
    
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
        if let formattedDate = formattedDateFromString(dateString: road.date,
                                                       withFormat: "dd MMM, yyyy") {
            self.date = formattedDate
        }
    }
   
    private func setupLayout() {
        self.tracedRoute.layer.cornerRadius = 10
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        
        return nil
    }

}
