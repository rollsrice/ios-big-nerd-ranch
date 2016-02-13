//
//  Place.swift
//  WorldTrotter
//
//  Created by Ryan Zhang on 2016-02-09.
//  Copyright © 2016 Ryan Zhang. All rights reserved.
//

import MapKit

class Place: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
}