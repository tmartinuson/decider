//
//  Landmark.swift
//  decider
//
//  Created by Tristan Martinuson on 2020-09-01.
//  Copyright © 2020 Tristan Martinuson. All rights reserved.
//

import Foundation
import MapKit

struct Landmark {
    
    let placemark: MKPlacemark
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
