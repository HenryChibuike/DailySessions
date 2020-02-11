//
//  ViewController.swift
//  HackingWithSwiftProject11MapKit
//
//  Created by Henry-chime chibuike on 2/11/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
lazy var map : MKMapView = {
    let map = MKMapView()
    map.translatesAutoresizingMaskIntoConstraints = false
    return map
}()
    lazy var floatingButton : UIButton = {
        let fb = UIButton(type: .custom)
        fb.translatesAutoresizingMaskIntoConstraints = false
//        fb.frame = CGRect(x: 265, y: 650, width: 50, height: 50)
//        fb.backgroundColor = .white
        fb.setImage(UIImage(named: "icons8-plus-500"), for: .normal)
        fb.clipsToBounds = true
        fb.layer.cornerRadius = 25
        return fb
    }()

    override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(map)
    view.addSubview(floatingButton)
    view.bringSubviewToFront(floatingButton)
    
    floatingButton.addTarget(self, action: #selector(Satelite), for: .touchUpInside)
   
        self.MapLayout()
   
    
    navigationItem.leftBarButtonItem = .init(title: "Satelite View", style: .done, target: self, action: #selector(Satelite))
    navigationItem.rightBarButtonItem = .init(title: "Hybrid View", style: .done, target: self, action: #selector(terriance))
    
    let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
    let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
    let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
    let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
    let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
    
    map.addAnnotations([london,oslo,paris,rome,washington])
}


func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
// 1
guard annotation is Capital else { return nil }

// 2
let identifier = "Capital"

// 3
var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

if annotationView == nil {
    //4
    annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
    annotationView?.canShowCallout = true

    // 5
    let btn = UIButton(type: .detailDisclosure)
    annotationView?.rightCalloutAccessoryView = btn
} else {
    // 6
    annotationView?.annotation = annotation
}

return annotationView
}
    
func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let capital = view.annotation as? Capital else { return }
    let placeName = capital.title
    let placeInfo = capital.info
    
    let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}

    
    
func MapLayout(){
    
    NSLayoutConstraint.activate([
        map.topAnchor.constraint(equalTo: view.topAnchor),
        map.leftAnchor.constraint(equalTo: view.leftAnchor),
        map.rightAnchor.constraint(equalTo: view.rightAnchor),
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        // floatingButton
    
        floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        floatingButton.heightAnchor.constraint(equalToConstant: 100),
        floatingButton.widthAnchor.constraint(equalToConstant: 100)
        
        
    ])
}
    
    @objc func Satelite(){
        var mapType : [MKMapType] = [
            .hybrid, .hybridFlyover, .mutedStandard, .satellite , .satelliteFlyover, .standard
        ]
        mapType.shuffle()
        map.mapType = mapType.randomElement()!
    }
    @objc func terriance(){
        map.mapType = .satellite
    }
    @objc func floating(){
        print("Tapped")
    }
}

