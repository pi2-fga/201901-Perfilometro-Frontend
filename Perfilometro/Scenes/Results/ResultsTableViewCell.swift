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
        if let formattedDate = setFormattedDate(date: road.date) {
            self.date = formattedDate.asString(style: .long)
        }
    }
   
    private func setupLayout() {
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
    
}
