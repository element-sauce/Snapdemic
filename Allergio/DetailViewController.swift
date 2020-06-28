//
//  DetailViewController.swift
//  Allergio
//
//  Created by Aditya Sharma on 6/27/20.
//  Copyright © 2020 billx. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var donationLbl: UILabel!
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
    
    @IBAction func stepper(_ sender: UIStepper) {
        donationLbl.text = "$" + String(sender.value) + "0";
    }
}
