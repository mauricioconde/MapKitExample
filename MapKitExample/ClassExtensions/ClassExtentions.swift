//
//  ClassExtentions.swift
//  MapKitExample
//
//  Created by Mauricio Conde on 13/01/15.
//  Copyright (c) 2015 gbmobile. All rights reserved.
//

import Foundation
import MapKit

extension MKPointAnnotation {
    
    convenience init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String){
        self.init()
        self.coordinate = coordinate;
        self.title = title;
        self.subtitle = subtitle;
    }
}