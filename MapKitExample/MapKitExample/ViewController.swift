//
//  ViewController.swift
//  MapKitExample
//
//  Created by Mauricio Conde  on 08/01/15.
//  Copyright (c) 2015 gbmobile. All rights reserved.
// http://www.raywenderlich.com/30001/overlay-images-and-overlay-views-with-mapkit-tutorial
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var mapTypeSegmentedControl: UISegmentedControl!
    
    var centerLattitud: CLLocationDegrees = 51.50007773;
    var centerLongitude: CLLocationDegrees = -0.1246402;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1 create the cener point
        let location = CLLocationCoordinate2D(latitude: centerLattitud, longitude: centerLongitude)
        
        // 2 Center the map on this point
        let span = MKCoordinateSpanMake(0.05, 0.05)
        centerMapOnLocation(location, span: span)
        
        //3 Add some annotations to the map
        addManyPins()
        AddKnownAnnotation()
        addRoute()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //MARK:- Custom Methods
    func centerMapOnLocation(location: CLLocation){
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D, span: MKCoordinateSpan){
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    ///Adds a fixed route on the mapView
    func addRoute(){
        var coordinates: [String] = ["{51.50014,-0.12414}","{51.50021,-0.12521}","{51.50028,-0.12628}","{51.50035,-0.12735}","{51.50042,-0.12842}","{51.50049,-0.12949}","{51.50056,-0.13056}","{51.50063,-0.13163}","{51.50070,-0.13270}","{51.50077,-0.13377}"];
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
    
    ///Adds one custom annotation of kind: 'Known place annotation'
    func AddKnownAnnotation() {
        
        var annotation: KnownPlaceAnnotation;
        var lattitud: CLLocationDegrees;
        var longitude: CLLocationDegrees;
        var location: CLLocationCoordinate2D;
        
        lattitud = 51.490729
        longitude = -0.124625
        
        location = CLLocationCoordinate2D(latitude: lattitud, longitude: longitude)
        
        annotation = KnownPlaceAnnotation(coordinate: location, title: "Custom", subtitle: "Annotation", type: PlaceType.Home)
        print("annottaion created")
        mapView.addAnnotation(annotation)
        print("annotation sent")
        
        
    }
    
    func addManyPins() {
        let MAX_ANNOTATIONS = 3
        var latitude: CLLocationDegrees!;
        var longitude: CLLocationDegrees!;
        var locations: [CLLocationCoordinate2D] = []
        
        
        for var i=0; i<MAX_ANNOTATIONS; i++ {
            latitude = CLLocationDegrees(51.50 + (Double(i) * 0.01))
            longitude = CLLocationDegrees(-0.1246402)
            locations.append(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        }
        
        for var j=0; j<MAX_ANNOTATIONS; j++ {
            let annotation = MKPointAnnotation()
            annotation.coordinate = locations[j]
            annotation.title = "Title \(j)"
            annotation.subtitle = "Subtitle \(j)"
            mapView.addAnnotation(annotation)
            
            if(j == 1) {
            mapView.selectAnnotation(annotation, animated: true)
            }
        }
        
        
    }
    
    
    ///Updates the view type for the mapView
    @IBAction func mapTypeChanged(sender: UISegmentedControl) {
        
        switch (self.mapTypeSegmentedControl.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapType.Standard;
            print("standar")
            break;
        case 1:
            self.mapView.mapType = MKMapType.Hybrid;
            print("hybrid")
            break;
        case 2:
            self.mapView.mapType = MKMapType.Satellite;
            print("satelite")
            break;
        default:
            break;
        }
    }
    
    
    
    
    //MARK:- Delegate methods
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is KnownPlaceAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
        }
        else {
            anView!.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as! KnownPlaceAnnotation
        anView!.image = UIImage(named:cpa.imageName)
        
        return anView
    }
    /*
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView? {
        let reuseId = "test"
        
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if view == nil {
            view = KnownPlacesAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            view.canShowCallout = true
        }
        else {
            view.annotation = annotation
        }
    
        return view;
    }*/
    
    ///For rendering routes on the mapView. If return nil no content is drawn
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline:MKPolyline = overlay as! MKPolyline;
        let aRenderer: MKPolylineRenderer = MKPolylineRenderer(polyline: polyline);
        
        aRenderer.strokeColor = UIColor.blackColor();
        aRenderer.lineWidth = 3;
        
        return aRenderer;
    }

}

