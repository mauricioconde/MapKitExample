//
//  MapViewCtrller.swift
//  MapKitExample
//
//  Created by Mauricio Conde on 06/03/15.
//  Copyright (c) 2015 gbmobile. All rights reserved.
//

import Foundation
import MapKit

class MapViewCtrller: MapViewController {
    //MARK: - Class methdos
    override func configure() {
        super.configure()
        
        addPointAnnotation(51.500729, longitude: -0.128625, title: "Title", subtitle: "Subtitle");
        addCustomAnnotation(51.500729, longitude: -0.124625, title: "Custom", subtitle: "Annotation", imageName: nil);
        let coordinates: [String] = ["{51.50014,-0.12414}","{51.50021,-0.12521}","{51.50028,-0.12628}","{51.50035,-0.12735}","{51.50042,-0.12842}","{51.50049,-0.12949}","{51.50056,-0.13056}","{51.50063,-0.13163}","{51.50070,-0.13270}","{51.50077,-0.13377}"];
        addRoute(coordinates);
    }
    
    
    
    
    //MARK: - Delegate methods
    override func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is CustomAnnotation) {
            return nil;
        }
        
        var annView = mapView.dequeueReusableAnnotationViewWithIdentifier(REUSE_ID_FOR_ANNOTATION_VIEW);
        if annView == nil {
            annView = MKAnnotationView(annotation: annotation, reuseIdentifier: REUSE_ID_FOR_ANNOTATION_VIEW);
            annView!.canShowCallout = true;
        }
        else {
            annView!.annotation = annotation;
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as! CustomAnnotation;
        annView!.image = UIImage(named:cpa.imageName);
        
        return annView;
    }
}
