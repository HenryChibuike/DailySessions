//
//  Person.swift
//  HackingWithSwiftProject7Faces
//
//  Created by Henry-chime chibuike on 2/6/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit

class Person: NSObject,Codable {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
}
