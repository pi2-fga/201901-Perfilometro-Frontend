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
    @IBOutlet weak var connectToRaspberry: UISwitch!
    
    // MARK: - Variables
    
    var sensors: [UITableViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let alert = UIAlertController(title: "Calibrar", message: "Você deseja calibrar este perfilômetro?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .cancel, handler: { _ in
                
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cofirmar", comment: "Default action"), style: .default, handler: { _ in
                MQTT_Manager.sharedInstance.calibrateSensors()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
