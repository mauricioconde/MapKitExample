//
//  KnownPlaces.swift
//  MapKitExample
//
//  Created by Mauricio Conde Xinastle on 09/01/15.
//  Copyright (c) 2015 gbmobile. All rights reserved.
//

import Foundation
import MapKit

class KnownPlaceAnnotation: CustomAnnotation {
    var type: PlaceType;
    
    
    
    
    // MARK: - Constructors
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, type: PlaceType){
        self.type = type;
        super.init(coordinate: coordinate,title: title, subtitle: subtitle)
    }
    
    convenience init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, type: PlaceType, imageName: String){
        self.init(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
        self.imageName = imageName
    }
    
    
}
