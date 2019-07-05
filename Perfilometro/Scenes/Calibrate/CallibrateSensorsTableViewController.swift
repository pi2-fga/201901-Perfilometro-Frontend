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
    @IBOutlet weak var connectToRaspberry: UISwitch!
    
    // MARK: - Variables
    
    var sensors: [UITableViewCell] = []
    var mQTTManager: MQTT_Manager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mQTTManager = MQTT_Manager()
        
        setupLayout()
    }
    
    @IBAction func changeSensorState(_ sender: Any) {
        if sensorStateSwitch.isOn {
           self.mQTTManager?.calibrateSensors()
        } else {
           
        }
    }
    
    @IBAction func connectToRaspberryPi(_ sender: Any) {
        if connectToRaspberry.isOn {
            self.mQTTManager?.connectToRaspberry()
        } else {
            self.mQTTManager?.disconnectToRaspberry()
        }
    }
    
    private func setupLayout() {
      
    }
    
}
