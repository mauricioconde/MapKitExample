//
//  Map.swift
//  MapKitExample
//
//  Created by Mauricio Conde Xinastle on 13/01/15.
//  Copyright (c) 2015 gbmobile. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var mapTypeSegmentedControl: UISegmentedControl!
    var centerLattitud: CLLocationDegrees!;
    var centerLongitude: CLLocationDegrees!;
    
    let LATTITUDE_DELTA: CLLocationDegrees = 0.05;
    let LONGITUDE_DELTA: CLLocationDegrees = 0.05;
    let REUSE_ID_FOR_ANNOTATION_VIEW = "annotationId"

    
    
    
    //MARK: - ViewController methdos
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    
    
    
    //MARK: - Class Methods
    func initMap(frame: CGRect){
        if(mapView == nil) { mapView = MKMapView(frame: frame); }
        mapView.delegate = self;
        
    }
    
    func addMapToView(view: UIView){
        if(mapView != nil) { view.addSubview(mapView); }
        
    }
    
    func setMapRegion(lattitud: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location    = CLLocationCoordinate2D(latitude: lattitud, longitude: longitude);
        let span        = MKCoordinateSpanMake(LATTITUDE_DELTA, LONGITUDE_DELTA);
        let region      = MKCoordinateRegion(center: location, span: span);
        
        if(mapView != nil) {mapView.setRegion(region, animated: true);}
    }
    
    func addPointAnnotation(lattitud: CLLocationDegrees, longitude: CLLocationDegrees, title: String, subtitle: String){
        let location    = CLLocationCoordinate2D(latitude: lattitud, longitude: longitude);
        let annotation  = MKPointAnnotation(coordinate: location, title: title, subtitle: subtitle);
        
        if(mapView != nil) {mapView.addAnnotation(annotation)}
    }
    
    func addCustomAnnotation(lattitud: CLLocationDegrees, longitude: CLLocationDegrees, title: String, subtitle: String, imageName: String!){
        let location    = CLLocationCoordinate2D(latitude: lattitud, longitude: longitude)
        let annotation = CustomAnnotation(coordinate: location, title: title, subtitle: subtitle)
        if(imageName != nil){annotation.imageName = imageName}
        
        if(mapView != nil) {mapView.addAnnotation(annotation)}
    }
    
    func addAnnotation(annotation: MKAnnotation){
        if(mapView != nil) {mapView.addAnnotation(annotation)}
    }
    
    func addRoute(coordinates: [String]){
        let pointsCount = coordinates.count;
        
        var pointsToUse: [CLLocationCoordinate2D] = [];
        
        for(var i=0; i<pointsCount; i++){
            let p: CGPoint = CGPointFromString(coordinates[i])
            let lat: CLLocationDegrees = CLLocationDegrees(p.x);
            let long: CLLocationDegrees = CLLocationDegrees(p.y);
            let location = CLLocationCoordinate2D(latitude: lat, longitude: long);
            pointsToUse.append(location);
        }
        
        let myPolyLine: MKPolyline = MKPolyline(coordinates: &pointsToUse, count: pointsCount);
        self.mapView.addOverlay(myPolyLine);
        
    }
    
    func configure(){
        if(mapView == nil){
            initMap(self.view.frame);
            addMapToView(self.view);
        }
        
        centerLattitud = 51.50007773;
        centerLongitude = -0.1246402;
        setMapRegion(centerLattitud, longitude: centerLongitude);
    }
    
    
    
    
    //MARK: - Delegate methods
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var annView = mapView.dequeueReusableAnnotationViewWithIdentifier(REUSE_ID_FOR_ANNOTATION_VIEW);
        if annView == nil {
            annView = MKAnnotationView(annotation: annotation, reuseIdentifier: REUSE_ID_FOR_ANNOTATION_VIEW);
            annView!.canShowCallout = true;
        }
        else {
            annView!.annotation = annotation;
        }
        
        return annView;
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline;
        
        let aRenderer: MKPolylineRenderer = MKPolylineRenderer(polyline: polyline);
        
        aRenderer.strokeColor = UIColor.blackColor();
        aRenderer.lineWidth = 3;
        
        return aRenderer;
        
        
    }
    
    
}