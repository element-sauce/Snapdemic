//
//  MapViewController.swift
//  Allergio
//
//  Created by Aditya Sharma on 6/28/20.
//  Copyright © 2020 billx. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    //CVS Pharmacy
    //37°18'59.3"N 122°02'01.6"W
    
    //Rite Aid
    //37°20'13.3"N 122°02'00.5"W
    
    //Walgreens
    //37°18'37.5"N 122°01'25.2"W
    
    //Kaiser Permanente
    //37°20'09.6"N 121°59'56.2"W
    
    //Valley Health Center
    //37.364786, -122.023355
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        let annotation1 = MKPointAnnotation()
            
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 37.31647222222222, longitude: -122.03377777777777)
        annotation1.title = "CVS Pharmacy"
        annotation1.subtitle = "Purchase Wipes"
        
        mapView.addAnnotation(annotation1)
        
        let annotation2 = MKPointAnnotation()
            
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 37.335989, longitude: -121.998933)
        annotation2.title = "Kaiser Permanente"
        annotation2.subtitle = "Donate Disinfectant Wipes"
        
        mapView.addAnnotation(annotation2)
        
        let annotation3 = MKPointAnnotation()
            
        annotation3.coordinate = CLLocationCoordinate2D(latitude: 37.337028, longitude: -122.033472)
        annotation3.title = "Rite Aid"
        annotation3.subtitle = "Obtain Wipes"
        
        mapView.addAnnotation(annotation3)
        
        let annotation4 = MKPointAnnotation()
            
        annotation4.coordinate = CLLocationCoordinate2D(latitude: 37.310417, longitude: -122.023667)
        annotation4.title = "Walgreens"
        annotation4.subtitle = "Obtain Disinfectant Wipes"
        
        mapView.addAnnotation(annotation4)
        
        let annotation5 = MKPointAnnotation()
            
        annotation5.coordinate = CLLocationCoordinate2D(latitude: 37.364786, longitude: -122.023355)
        annotation5.title = "Valley Health Center"
        annotation5.subtitle = "Donate Disinfectant Wipes"
        
        mapView.addAnnotation(annotation5)
        
        let region = MKCoordinateRegion(center: annotation1.coordinate, latitudinalMeters: 9000, longitudinalMeters: 9000)

        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        let detail = storyboard?.instantiateViewController(identifier: "detail") as? DetailViewController
        view.window?.rootViewController = detail
        view.window?.makeKeyAndVisible()
    }
    
}
