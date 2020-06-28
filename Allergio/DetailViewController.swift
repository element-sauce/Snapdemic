//
//  DetailViewController.swift
//  Allergio
//
//  Created by Aditya Sharma on 6/27/20.
//  Copyright © 2020 billx. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        let profile = storyboard?.instantiateViewController(identifier: "profile") as? ProfileViewController
        view.window?.rootViewController = profile
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func clickMapButton(_ sender: UIButton) {
        // Open Maps
        let map = storyboard?.instantiateViewController(identifier: "map") as? MapViewController
        view.window?.rootViewController = map
        view.window?.makeKeyAndVisible()
    }
}
