//
//  KnowmPlacesView.swift
//  MapKitExample
//
//  Created by Mauricio Conde Xinastle on 09/01/15.
//  Copyright (c) 2015 gbmobile. All rights reserved.
//

import Foundation
import MapKit

class KnownPlacesAnnotationView: MKAnnotationView {
    
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let img = UIImage(named: "Home")
        self.image = img
        self.frame = CGRectMake(0, 0, 40, 40)
        self.layer.cornerRadius = 20
        self.contentMode = UIViewContentMode.ScaleAspectFit
        self.centerOffset = CGPointMake(0, -20)
    }
    
     /*override init(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        println("created")
        let knownPlaceAnnotation: KnownPlaceAnnotation = self.annotation as KnownPlaceAnnotation;
        println("switch")
        switch knownPlaceAnnotation.type{
        case PlaceType.Home:
            println("is Home")
            self.image = UIImage(named:"Home")
            println("img sent")
            break
        case .Job:
            self.image = UIImage(named: "Job")
            break
        default:
            self.image = UIImage(named: "Star")
            break
        }
    }*/

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}