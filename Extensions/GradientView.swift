//
//  GradientView.swift
//  CalendaeApp
//
//  Created by Artyom Beldeiko on 7.06.21.
//

import Foundation
import UIKit

@IBDesignable
class GradientView: UIButton {
    @IBInspectable var topColor: UIColor = .white
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 1, green: 0.5183262825, blue: 0.2250643969, alpha: 1)
    
    var startPointX: CGFloat = 0
    var startPointY: CGFloat = 0
    var endPointX: CGFloat = 1
    var endPointY: CGFloat = 1
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint (x: startPointX, y:startPointY)
        gradientLayer.endPoint = CGPoint (x: endPointX, y: endPointY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        
    }
    
    
}
