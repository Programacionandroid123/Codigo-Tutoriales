//
//  ViewController.swift
//  GoogleMapsPrueba
//
//  Created by Codelia on 4/4/20.
//  Copyright © 2020 Codelia. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {
    
    var mapView: GMSMapView!
    var cargoMapa: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let camera = GMSCameraPosition.camera(withLatitude: 20.980, longitude: -89.722, zoom: 4.0)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.settings.indoorPicker = false
        mapView.delegate = self
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("No se encontro archivo style.json")
            }
        } catch {
            NSLog("Fallo en cargar json de estilo. \(error)")
        }
        
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
    
    
    func agregarMarcadores() {
        let colors: [UIColor] = [.black, .red, .blue, .cyan]
        
        for i in 1...10 {
            let marker = GMSMarker()
            let latitude_add = Float.random(in: 0.1 ..< 0.75)
            let longitude_add = Float.random(in: 0.1 ..< 0.75)
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(19.389 + latitude_add), longitude: CLLocationDegrees(-99.178 + longitude_add))
            marker.title = "Ciudad de Mexico, \(i)"
            marker.snippet = "Coordenadas: \(latitude_add), \(longitude_add)"
            marker.map = mapView
            marker.icon = GMSMarker.markerImage(with: colors.randomElement())
        }
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 19.06, longitude: -99.05)
        marker2.title = "Banco"
        marker2.map = mapView
        marker2.icon = UIImage(named: "baseline_account_balance_black_48pt_1x")
        
        CATransaction.begin()
        CATransaction.setValue(Int(3), forKey: kCATransactionAnimationDuration)
        let camera = GMSCameraPosition(latitude: 19.06, longitude: -99.05, zoom: 12)
        mapView.animate(to: camera)
        CATransaction.commit()
    }
    
    
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        if (!cargoMapa) {
            cargoMapa = true
            agregarMarcadores()
        }
    }
}

