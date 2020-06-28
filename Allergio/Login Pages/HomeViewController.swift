//
//  HomeViewController.swift
//  Allergio
//
//  Created by Aditya Sharma on 6/23/20.
//  Copyright © 2020 billx. All rights reserved.
//

import Clarifai_Apple_SDK
import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var introPredictTextView: UITextView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var predictButton: UIButton!
    @IBOutlet weak var predictionsTableView: UITableView!
    @IBOutlet weak var chooseImageButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    let slideInTransition = SlideInTransition()
    
    var concepts: [Concept] = []
    var model: Model!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.model = Clarifai.sharedInstance().generalModel

        predictionsTableView.layer.borderWidth = 0.20
        predictionsTableView.layer.borderColor = UIColor.gray.cgColor
        predictionsTableView.dataSource = self
        predictionsTableView.delegate = self
    }

    @IBAction func chooseImage(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            previewImageView.image = image
        }
    
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func predict(_ sender: Any) {
        self.concepts.removeAll()

        if self.predictionsTableView.isHidden {
            self.predictionsTableView.isHidden = false
            self.introPredictTextView.isHidden = true
        }
        
        let image = Image(image: self.previewImageView.image)
        let dataAsset = DataAsset.init(image: image)

        let input = Input.init(dataAsset:dataAsset)
        let inputs = [input]

        self.model.predict(inputs, completionHandler: {(outputs: [Output]?,error: Error?) -> Void in
            // iterate through outputs to learn about what has been predicted
            for output in outputs! {
                // output concepts are being added to an array to be displayed.
                self.concepts.append(contentsOf: output.dataAsset.concepts!)
            }

            DispatchQueue.main.async {
                self.predictionsTableView.reloadData()
            }
        })
    }

    // MARK: internal tableview methods
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return concepts.count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("wait whattttt")
        let cell = predictionsTableView.dequeueReusableCell(withIdentifier: "predictions") as! PredictionsCell

        cell.conceptLabel.text = self.concepts[indexPath.item].name
        cell.scoreLabel.text = String(format: "%.5f", self.concepts[indexPath.item].score)

        return cell
    }
    
    // MARK: Menu Bar
    @IBAction func didTapMenu(_ sender: UIButton) {
        guard let menu = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menu.didTapMenuType = { menuType in
//            print(menuType)
            self.transitionToNewContent(menuType);
        }
        menu.modalPresentationStyle = .overCurrentContext
        menu.transitioningDelegate = self
        present(menu, animated: true)
    }
    
    func transitionToNewContent(_ menuType: MenuType) {
        let title = String(describing: menuType).capitalized
        self.title = title
        
        switch menuType{
        case .profile:
            
            let homeViewController = storyboard?.instantiateViewController(identifier: "profile") as? ProfileViewController
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
            
//            let collectionView: UICollectionView = {
//                let layout = UICollectionViewFlowLayout()
//                layout.scrollDirection = .horizontal
//                let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//                cv.translatesAutoresizingMaskIntoConstraints = false
//                cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
//                return cv
//            }()
//
//
//            let view = UIView()
//            view.backgroundColor = .yellow
//            view.frame = self.view.bounds
//            self.view.addSubview(view)
//            self.view.addSubview(collectionView)
//            collectionView.backgroundColor = .white
//            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
//            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
//            collectionView.delegate = self
//            collectionView.dataSource = self
        default:
            break
        }
    }
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideInTransition.isPresenting = true
        return slideInTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideInTransition.isPresenting = false
        return slideInTransition
    }
}

//extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
//        cell.backgroundColor = .red
//        return cell
//    }
//}
//
//class CustomCell: UICollectionViewCell {
//    
//    fileprivate let bg:UIImageView = {
//        let iv = UIImageView()
//        //iv.image = #imageLiteral(resourceName: "island2")
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.contentMode = .scaleAspectFit
//        iv.clipsToBounds = true
//        return iv
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(bg)
//        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
