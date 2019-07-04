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
    
    @IBOutlet weak var sensor1: UITableViewCell!
    @IBOutlet weak var sensor2: UITableViewCell!
    @IBOutlet weak var sensor3: UITableViewCell!
    @IBOutlet weak var sensor4: UITableViewCell!
    @IBOutlet weak var sensor5: UITableViewCell!
    @IBOutlet weak var sensor6: UITableViewCell!
    @IBOutlet weak var sensor7: UITableViewCell!
    @IBOutlet weak var sensor8: UITableViewCell!
    @IBOutlet weak var sensor9: UITableViewCell!
    @IBOutlet weak var sensor10: UITableViewCell!
    

    @IBOutlet weak var sensorStateSwitch: UISwitch!
    
    // MARK: - Variables
    
    var sensors: [UITableViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    @IBAction func changeSensorState(_ sender: Any) {
        if sensorStateSwitch.isOn {
            showSensorCells()
        } else {
            hideSensorCells()
        }
    }
    
    
    private func setupLayout() {
        setupCells()
    }
    
    private func hideSensorCells() {
        for sensor in sensors {
            UIView.animate(withDuration: 0.2) {
                sensor.contentView.isHidden = true
            }
        }
    }
    
    private func showSensorCells() {
        for sensor in sensors {
            UIView.animate(withDuration: 0.2) {
                sensor.contentView.isHidden = false
            }
        }
    }

    
    private func setupCells() {
    sensors = [ sensor1,
                sensor2,
                sensor3,
                sensor4,
                sensor5,
                sensor6,
                sensor7,
                sensor8,
                sensor9,
                sensor10]
    }
}
