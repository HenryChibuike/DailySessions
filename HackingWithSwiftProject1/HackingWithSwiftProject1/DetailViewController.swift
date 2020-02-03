//
//  DetailViewController.swift
//  HackingWithSwiftProject1
//
//  Created by Henry-chime chibuike on 1/30/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage
        //
        navigationItem.largeTitleDisplayMode = .never
//        navigationController?.navigationBar.prefersLargeTitles = false
        
        // for the optional selectedImage
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    //when image is tapped the navigation view will dissappear
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = true
    }

    // this brings back the navigation view when image is tapped
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
