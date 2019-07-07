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
    
    @IBOutlet weak var calibrateBtn: UIButton!
    @IBOutlet weak var sensorStateSwitch: UISwitch!
    @IBOutlet weak var connectToRaspberry: UISwitch!
    
    // MARK: - Variables
    
    var sensors: [UITableViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    @IBAction func changeSensorState(_ sender: Any) {
        
        MQTT_Manager.sharedInstance.calibrateSensors()
    }
    
    @IBAction func connectToRaspberryPi(_ sender: Any) {
        if connectToRaspberry.isOn {
            MQTT_Manager.sharedInstance.connectToRaspberry()
        } else {
            MQTT_Manager.sharedInstance.disconnectToRaspberry()
        }
    }
    
    private func setupLayout() {
      
    }
    
}
