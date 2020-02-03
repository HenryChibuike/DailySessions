//
//  ViewController.swift
//  HackingWithSwiftProject1
//
//  Created by Henry-chime chibuike on 1/30/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default // getting the file bundle of the app
        let path = Bundle.main.resourcePath! // this is the path of the app and this is always avaliable
        let items = try! fm.contentsOfDirectory(atPath: path) // this is getting the content of the app as a path
        var sortedItems = items.sorted{$0 < $1}
        
        for item in sortedItems {
            if item.hasPrefix("nssl"){

                pictures.append(item)
                
            }
            
        }
        
        print(pictures)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }
}

