//
//  UIVIew.swift
//  HackingWithSwiftProject9Filter
//
//  Created by Henry-chime chibuike on 2/11/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubViews(_ views: [Any]) {
        views.forEach({ self.addSubview($0 as! UIView) })
    }
}
