//
//  ProfileViewController.swift
//  Allergio
//
//  Created by Aditya Sharma on 6/27/20.
//  Copyright © 2020 billx. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let locationName = ["Surgical Face Mask", "Hand Sanitizer", "Disinfectant Wipes", "Disposable Gloves"]
    let locationImage = [UIImage(named: "mask"), UIImage(named: "sanitizer"), UIImage(named: "wipes"), UIImage(named: "gloves")]
    let locationDesc = ["You must wear a surgical face mask in public settings", "Regularly apply hand sanitizer for personal hygiene and safety measures.", "Clean surfaces with disinfectant wipes to slow the spread", "Wear gloves when carrying items in the public and wash your hands"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.locationName.text = locationName[indexPath.row]
        cell.locationImage.image = locationImage[indexPath.row]
        cell.locationDescription.text = locationDesc[indexPath.row]
        
        // Creates the shadows and modifies the cards
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.gray.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
//        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:  cell.contentView.layer.cornerRadius).cgPath
        return cell
    }

    @IBAction func backBtnTapped(_ sender: UIButton) {
        let homeViewController = storyboard?.instantiateViewController(identifier: "homeVC") as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func infoBtnTapped(_ sender: Any) {
        let detail = storyboard?.instantiateViewController(identifier: "detail") as? DetailViewController
        view.window?.rootViewController = detail
        view.window?.makeKeyAndVisible()
    }
    
}
