//
//  BluetoothManager.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 09/05/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import CoreBluetooth
import UIKit

class BluetoothManager: UIViewController {
    
    var centralManager: CBCentralManager!
    let raspCBUUID = CBUUID(string: "0x2806")
    var raspPeripherical: CBPeripheral!
    
    func startBluethoothManager(delegate: CBCentralManagerDelegate) {
        centralManager = CBCentralManager(delegate: delegate, queue: nil)
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("Central.state is .unknown")
        case .resetting:
            print("Central.state is .resetting")
        case .unsupported:
            print("Central.state is . unsupported")
        case .unauthorized:
            print("Central.state is .unauthorized")
        case .poweredOff:
            print("Central.state is .poweredOff")
        case .poweredOn:
            print("Central.state is .poweredOn")
            centralManager.scanForPeripherals(withServices: nil)
        default:
            print("unpreviewd case")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        //    self.raspPeripherical = peripheral
        //    self.raspPeripherical.delegate = self
        //    centralManager.stopScan()
        //    centralManager.connect(raspPeripherical)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected")
        self.raspPeripherical.discoverServices(nil)
        
    }
}

extension BluetoothManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {return}
        for service in services {
            print(service)
            peripheral.discoverCharacteristics(nil, for: service)
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        guard let characteristics = service.characteristics else { return  }
        
        for characteristic in characteristics {
            print(characteristic)
            if characteristic.properties.contains(.read) {
                peripheral.readValue(for: characteristic)
            }
            if characteristic.properties.contains(.notify) {
                print("\(characteristic.uuid): properties contains .notify")
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        //    switch characteristic.uuid {
        //
        //    default:
        //      <#code#>
        //    }
    }
}

