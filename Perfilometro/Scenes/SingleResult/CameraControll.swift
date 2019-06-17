//
//  CameraControll.swift
//  SceneKitGraph
//
//  Created by Geovanni Oliveira de Jesus on 17/06/19.
//  Copyright © 2019 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation
import SpriteKit

class CameraControll: SKScene {
    
    //Buttons
    var forwardBtn: SKSpriteNode?
    var backwardBtn: SKSpriteNode?
    
    var moveDelegate: MoveCameraDelegate?
    
    override init(size: CGSize) {
        super.init(size: size)
        setupForwardBtn(size: size)
        setupBackwardBtn(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupForwardBtn(size: CGSize) {
        self.forwardBtn = SKSpriteNode(imageNamed: "forward")//SKShapeNode(rect: CGRect(x: size.width * 0.5, y: size.height * 0.3, width: 60, height: 20))
        self.forwardBtn?.position = CGPoint(x: size.width * 0.7, y: size.height * 0.3)
        self.forwardBtn?.setScale(CGFloat(0.6))
//        self.forwardBtn?.fillColor = UIColor.white
        self.forwardBtn?.name = "ForwardButton"
        self.addChild(self.forwardBtn!)
    
    }
    
    func setupBackwardBtn(size: CGSize) {
        self.backwardBtn = SKSpriteNode(imageNamed: "back")//SKShapeNode(rect: CGRect(x: size.width * 0.3, y: size.height * 0.3, width: 60, height: 20))
        self.backwardBtn?.position = CGPoint(x: size.width * 0.3, y: size.height * 0.3)
        self.backwardBtn?.setScale(CGFloat(0.6))
//        self.backwardBtn?.fillColor = UIColor.blue
        self.backwardBtn?.name = "BackwardButton"
        self.addChild(self.backwardBtn!)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (backwardBtn?.contains((touches.first?.location(in: self))!))! {
            print("Move backwards")
            self.moveDelegate!.moveCameraBackward()
            
            
        } else if (forwardBtn?.contains((touches.first?.location(in: self))!))! {
            print("Move forward")
            self.moveDelegate!.moveCameraForward()
            
            
        }
    }
    
    
}
