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


    @IBOutlet weak var roadName: UILabel!
    
    @IBOutlet weak var tracedRoute: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRoadName(name: String) {
        self.roadName.text = name
    }

}
