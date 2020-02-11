//
//  Capital.swift
//  HackingWithSwiftProject11MapKit
//
//  Created by Henry-chime chibuike on 2/11/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
