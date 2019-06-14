//
//  SingleResultViewController.swift
//  Perfilometro
//
//  Created by Geovanni Oliveira de Jesus on 14/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit
import MapKit
import SceneKit

class SingleResultViewController: UIViewController {

    @IBOutlet weak var routeName: UILabel!
    @IBOutlet weak var routeInMap: MKMapView!
    @IBOutlet weak var graph: SCNView!
    @IBOutlet weak var routeInfo: UITextView!
    
    var roadname: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        routeName.text = roadname
        // Do any additional setup after loading the view.
    }

}
