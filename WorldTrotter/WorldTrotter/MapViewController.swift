//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Ryan Zhang on 2016-02-07.
//  Copyright © 2016 Ryan Zhang. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var mapView: MKMapView!
    var zoomButton: UIButton!
    var pins: [MKAnnotation]!
    var pinIndex: Int!
    var locManager: CLLocationManager!
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        
        initSegmentedControl()
        initZoomButton()
        initPins()
        initPinButton()
    }
    
    func initPins() {
        pins = [Place(title: "Workplace", coordinate: CLLocationCoordinate2DMake(40.741111, -73.987448)),
            Place(title: "Birthplace", coordinate: CLLocationCoordinate2DMake(26.074508, 119.296494)),
            Place(title: "Coolplace", coordinate: CLLocationCoordinate2DMake(7.746116, 98.778410))]
        pinIndex = 0
    }
    
    func initPinButton() {
        let btn = UIButton()
        btn.setTitle("Next Pin", forState: .Normal)
        btn.setTitleColor(view.tintColor, forState: .Normal)
        btn.frame = CGRectMake(100, 100, 100, 100)
        btn.addTarget(self, action: "showNextPin:", forControlEvents: .TouchUpInside)
        view.addSubview(btn)
        
        placePinButton(btn)
    }
    
    func placePinButton(btn: UIButton) {
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.trailingAnchor.constraintEqualToAnchor(zoomButton.trailingAnchor).active = true
        btn.bottomAnchor.constraintEqualToAnchor(zoomButton.topAnchor, constant: -8).active = true
    }
    
    func initZoomButton() {
        let btn = UIButton()
        zoomButton = btn
        btn.setTitle("Zoom", forState: .Normal)
        btn.setTitleColor(view.tintColor, forState: .Normal)
        btn.frame = CGRectMake(100, 100, 100, 100)
        btn.addTarget(self, action: "zoomToUserPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(btn)
        
        placeZoomButton(btn)
    }
    
    func placeZoomButton(btn: UIButton) {
        let margins = view.layoutMarginsGuide
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        btn.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor, constant: -8).active = true
    }
    
    func initSegmentedControl() {
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "mapTypeChanged:", forControlEvents: .ValueChanged)
        
        placeSegmentedControl(segmentedControl)
    }
    
    func placeSegmentedControl(control: UISegmentedControl) {
        control.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(control)
        
        let margins = view.layoutMarginsGuide
        let topConstraint = control.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        let leadingConstraint = control.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = control.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager = CLLocationManager()
        locManager.delegate = self
        if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
            locManager!.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedWhenInUse)
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
    
    func zoomToUserPressed(button: UIButton) {
        var mapRegion = MKCoordinateRegion()
        mapRegion.center = mapView.userLocation.coordinate
        mapRegion.span.latitudeDelta = 0.2
        mapRegion.span.longitudeDelta = 0.2
        
        mapView.setRegion(mapRegion, animated: true)
    }
    
    func mod(x: Int, m: Int) -> Int {
        return (x % m + m) % m
    }
    
    func showNextPin(button: UIButton) {
        mapView.removeAnnotation(pins[mod(pinIndex - 1, m: 3)])
        mapView.addAnnotation(pins[pinIndex])
        pinIndex = mod(pinIndex + 1, m: 3)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKPinAnnotationView
        if let annotation = annotation as? Place {
            let identifier = annotation.title
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier!) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                annotationView = dequeuedView
            }
            else {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier!)
                annotationView.canShowCallout = true
            }
            return annotationView
        }
        return nil
    }
}