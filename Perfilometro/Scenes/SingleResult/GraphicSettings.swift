//
//  ExempleData.swift
//  SceneKitGraph
//
//  Created by Geovanni Oliveira de Jesus on 15/06/19.
//  Copyright © 2019 Geovanni Oliveira de Jesus. All rights reserved.
//

import SpriteKit

class GraphicSettings {
    
    let numberOfSensors = 10
    
    var sensorValues:[[Float]] = []
    var sensor1Values:[Float] = []//[25.3, 28.37, 32.19, 36.84, 39.79, 44.28, 51.12, 60.42, 58.44, 62.48, 69.94, 73.72]
    var sensor2Values:[Float] = []//[5.36, 4.74, 6.21, 8.28, 13.93, 19.32, 24.01, 32.48, 36.54, 65.22, 108.25, 148.81]
    var sensor3Values:[Float] = []//[0.0, 0.43951, 1.47, 3.19, 6.14, 10.6, 16.59, 21.8, 23.65, 29.32, 37.91, 43.16]
    var sensor4Values:[Float] = []//[10.4, 14.6, 18.9, 10.6, 20.5, 22.1, 24.0, 17.8, 19.3, 25.9, 20.9, 28.5]
    var sensor5Values:[Float] = []//[5.3, 8.37, 2.19, 6.84, 9.79, 4.28, 1.12, 0.42, 8.44, 2.48, 9.94, 3.72]
    var sensor6Values:[Float] = [10.21, 9.35, 6.43, 2.32, 3.22]//[15.36, 14.74, 16.21, 18.28, 23.93, 29.32, 24.01, 42.48, 46.54, 75.22, 80.25, 108.81]
    var sensor7Values:[Float] = [6.21, 9.35, 6.43, 14.32, 10.22]//[0.0, 10.43951, 21.47, 32.19, 46.14, 13.6, 36.59, 11.8, 13.65, 9.32, 17.91, 63.16]
    var sensor8Values:[Float] = [11.21, 14.35, 27.43, 14.32, 13.22]//[53.3, 44.37, 22.19, 46.84, 39.79, 46.28, 17.12, 20.42, 68.44, 28.48, 29.94, 63.72]
    var sensor9Values:[Float] = [6.21, 3.35, 7.43, 10.32, 20.22]//[45.3, 48.37, 32.19, 56.84, 96.79, 74.28, 61.12, 70.42, 58.44, 42.48, 95.94, 83.72]
    var sensor10Values:[Float] = [1.21, 4.35, 7.43, 4.32, 23.22]//[58.3, 87.37, 29.19, 16.84, 49.79, 64.28, 71.12, 80.42, 98.44, 32.48, 49.94, 23.72]
    
    func updateValues() {
        
        sensorValues.append(sensor1Values)
        sensorValues.append(sensor2Values)
        sensorValues.append(sensor3Values)
        sensorValues.append(sensor4Values)
        sensorValues.append(sensor5Values)
        sensorValues.append(sensor6Values)
        sensorValues.append(sensor7Values)
        sensorValues.append(sensor8Values)
        sensorValues.append(sensor9Values)
        sensorValues.append(sensor10Values)
        
    }
    
    
    func numberOfRows() -> Int {
        return numberOfSensors
    }
    
    func numberOfColums() -> Int {
        //All the sensors have the same amount of values, so it does not matter what sensor's length it will be taken
        return self.sensor1Values.count
    }
    
    func legendForRow(_ row:Int) -> String {
        if (row == 0) {
            return "Sensor 1"
        }else if (row == 1) {
            return "Sensor 2"
        }else if (row == 2) {
            return "Sensor 3"
        } else if (row == 3) {
            return "Sensor 4"
        } else if (row == 4) {
            return "Sensor 5"
        } else if (row == 5) {
            return "Sensor 6"
        } else if (row == 6) {
            return "Sensor 7"
        } else if (row == 7) {
            return "Sensor 8"
        } else if (row == 8) {
            return "Sensor 9"
        } else if (row == 9) {
            return "Sensor 10"
        }
        else {
            return "Sensors out of range 0-9 "
        }
    }
    
    //    func legendForColumn(_ column:Int) -> String {
    //        return String(format:"%d", 2001 + column)
    //    }
    
    func maxValueForData() -> Float {
        return 150.0
    }
    
    func valueForIndexPath(row:Int, column:Int) -> Float {
        //        return gValsRevenue[row * numberOfColumns + column]
        
        var value:Float = -1
        
        if (row >= 0 && row <= 10) {
            //            value = gValsRevenue[row][column]
            value = sensorValues[row][column]
        }
        return value
    }
    
    func colorForIndexPath(row:Int, column:Int) -> SKColor {
        let val:Float = self.valueForIndexPath(row:row, column:column)
        let max:Float = 150.0
        let value:Float = Float(val/max)
        let hue = 0.3 + Float(row) / 6.0
        let sat = 0.2 + value/1.25
        
        let color = UIColor(hue: CGFloat(hue), saturation: CGFloat(sat), brightness: 1.0, alpha: 1.0)
        return color;
        
    }
}

