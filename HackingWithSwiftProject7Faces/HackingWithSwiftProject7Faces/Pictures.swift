//
//  Pictures.swift
//  HackingWithSwiftProject7Faces
//
//  Created by Henry-chime chibuike on 2/6/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit

class Pictures: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let cellid = "cellid"
    var people = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(ImagePicker))
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: cellid)
        collectionView.backgroundColor = .init(white: 0.96, alpha: 1)
        
        
        //
        
        let defaults = UserDefaults.standard

        if let savedPeople = defaults.object(forKey: "people") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                people = try jsonDecoder.decode([Person].self, from: savedPeople)
            } catch {
                print("Failed to load people")
            }
        }
    }
    
    @objc func ImagePicker(){
        
           let picker = UIImagePickerController()
           picker.allowsEditing = true
            picker.delegate = self
           present(picker, animated: true)
       }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! PictureCell
        
        let person = people[indexPath.item]
        
        cell.label.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let person = people[indexPath.item]
        
        
        let name = UIAlertController(title: "😁", message: "", preferredStyle: .alert)
        name.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
            
            print("deleted")
            
//            person.name = ""
//            person.image = ""
            self.people.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
            
            collectionView.reloadData()
            
        }))
       
        
        
        name.addAction(UIAlertAction(title: "Rename", style: .default, handler: {
            [weak self] _ in
            let rename = UIAlertController(title: "New Name", message: "", preferredStyle: .alert)
            rename.addTextField()
            rename.addAction(UIAlertAction(title: "Rename", style: .default, handler: {
                _ in
                guard let newRename = rename.textFields?[0].text else {return}
                
                person.name = newRename
                self?.save()
                self?.collectionView.reloadData()
            }))
            self?.present(rename, animated: true)

        }))
        present(name, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        
        // takes the data and store it in NsObject
        let person = Person(name: "Tap to Edit", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    //save function
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(people) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        } else {
            print("Failed to save people.")
        }
    }
    
    // always do this in your collection view
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
