//
//  CallibrateSensorsTableViewController.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 30/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

class CallibrateSensorsTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var sensorStateSwitch: UISwitch!
    
    // MARK: - Variables
    
    var sensors: [UITableViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    @IBAction func changeSensorState(_ sender: Any) {
        if sensorStateSwitch.isOn {
           
        } else {
           
        }
    }
    
    
    private func setupLayout() {
      
    }
    
}
