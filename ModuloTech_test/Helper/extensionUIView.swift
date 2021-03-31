//
//  extensionUIView.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 29/03/2021.
//

import Foundation
import UIKit

 extension UIView
 {
    func makeVertical(){
         transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }
    
    func makeUpsideDown() {
        transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    }
 }
