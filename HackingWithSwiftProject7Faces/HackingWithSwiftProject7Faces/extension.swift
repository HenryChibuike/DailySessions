//
//  extension.swift
//  HackingWithSwiftProject7Faces
//
//  Created by Henry-chime chibuike on 2/6/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit

extension UIView {
    
    
    func centerInSuperview(size: CGSize = .zero) {
         translatesAutoresizingMaskIntoConstraints = false
         if let superviewCenterXAnchor = superview?.centerXAnchor {
             centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
         }
         
         if let superviewCenterYAnchor = superview?.centerYAnchor {
             centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
         }
         
         if size.width != 0 {
             widthAnchor.constraint(equalToConstant: size.width).isActive = true
         }
         
         if size.height != 0 {
             heightAnchor.constraint(equalToConstant: size.height).isActive = true
         }
     }
}
