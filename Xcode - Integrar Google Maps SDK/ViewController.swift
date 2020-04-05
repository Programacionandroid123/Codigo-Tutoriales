//
//  ViewController.swift
//  GoogleMapsPrueba
//
//  Created by Codelia on 4/4/20.
//  Copyright © 2020 Codelia. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let camera = GMSCameraPosition.camera(withLatitude: 19.3898, longitude: -99.178, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.settings.indoorPicker = false
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(mapView)
        view.sendSubviewToBack(mapView)
        mapView.isHidden = false
        
        // Marker
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 19.389, longitude: -99.178)
        marker.title = "Ciudad de Mexico"
        marker.snippet = "Mexico"
        marker.map = mapView
    }
}

