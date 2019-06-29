//
//  MapViewDesignable.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 29/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

@IBDesignable
class UIMapViewDesignable: UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.black {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable
    var isCircle: Bool = false {
        didSet {
            self.cornerRadius = self.bounds.height / 2
        }
    }
}

