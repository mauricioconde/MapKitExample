//
//  CustomAnnotation.swift
//  MapKitExample
//
//  Created by Mauricio Conde on 06/03/15.
//  Copyright (c) 2015 gbmobile. All rights reserved.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D;
    var title: String?;
    var subtitle: String?;
    var imageName: String;
    
    let DEFAULT_IMAGE_NAME = "HOME"
    
    
    
    //MARK: - Constructors
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String){
        self.coordinate = coordinate;
        self.title = title;
        self.subtitle = subtitle;
        self.imageName = self.DEFAULT_IMAGE_NAME
    }
    
    convenience init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, imageName: String){
        self.init(coordinate: coordinate, title: title, subtitle: subtitle)
        self.imageName = imageName
    }
    
    
    
    
    //MARK: - Class methods
    func applyCoordinate(location: CLLocationCoordinate2D){
        self.coordinate = location
    }
    
    
}
