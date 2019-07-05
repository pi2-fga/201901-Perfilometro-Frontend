//
//  MQTT_Manager.swift
//  Perfilometro
//
//  Created by Geovanni Oliveira de Jesus on 04/07/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import CocoaMQTT

class MQTT_Manager {
    
    var mqttClient: CocoaMQTT?
    let mqttServerIP = "postman.cloudmqtt.com"
    let mqttPort: UInt16 = 13504
    let clientID = "iOS App Device"

    init() {
        mqttClient = CocoaMQTT(clientID: clientID, host:  mqttServerIP, port: mqttPort)
        mqttClient?.username = "ioqvlgfd"//"iOSApp"
        mqttClient?.password = "xL0pD1ldNz9u"//"iOSApp"
        mqttClient?.delegate = self
    }
    
    func turnSensorsOn () {
        mqttClient?.publish("sensors", withString: "on")
    }
    
    func turnSensorsOff () {
        mqttClient?.publish("sensors", withString: "off")
    }
    
    func calibrateSensors() {
        mqttClient?.publish("sensors", withString: "calibrate")
    }
    
    func connectToRaspberry() {
        mqttClient?.connect()
    }
    
    func disconnectToRaspberry() {
        mqttClient?.disconnect()
    }
}

extension MQTT_Manager: CocoaMQTTDelegate {
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topics: [String]) {
    
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("Connectou")
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("Publicou a mensagem")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("Desconectou")
    }
    
}
