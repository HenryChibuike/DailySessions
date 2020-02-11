//
//  ViewController.swift
//  HackingWithSwiftProject9Filter
//
//  Created by Henry-chime chibuike on 2/10/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var mainView: UIView = {
        let mv = UIView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.backgroundColor = .white
        return mv
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .gray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var slider: UISlider = {
        let s = UISlider()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    lazy var tensityLabel : UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.text = "Tensity"
        tl.textColor = .systemBlue
        return tl
    }()
    
    lazy var changeFilterButton: UIButton = {
        let cfb = UIButton()
        cfb.translatesAutoresizingMaskIntoConstraints = false
        cfb.setTitle("Change Filter", for: .normal)
        cfb.setTitleColor(.systemBlue, for: .normal)
        cfb.addTarget(self, action: #selector(changeFilter), for: .touchUpInside)
        return cfb
    }()
    
    lazy var SaveButton: UIButton = {
        let sb = UIButton()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.setTitle("Save", for: .normal)
        sb.setTitleColor(.systemBlue, for: .normal)
//        sb.addTarget(self, action: #selector(saveButton), for: .touchUpInside)

        return sb
    }()
    // End of ui code
    

    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(white: 0.96, alpha: 1)
        
        view.addSubViews([mainView, imageView, slider, tensityLabel, changeFilterButton, SaveButton])
        
        SaveButton.addTarget(self, action: #selector(self.saveButton), for: .touchUpInside)
        slider.addTarget(self, action: #selector(self.sliderAction), for: .valueChanged)
        Layout()
        title = "ChiFilter"
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(imagePicker))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
        

    }
    // End of ViewDidLoad

    @objc func saveButton(){
        guard let image = imageView.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func imagePicker(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
        imageView.image = currentImage
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    }
    
    
    @objc func sliderAction(){
         applyProcessing()
    }
    
    @objc func changeFilter(){
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
        }
    
    func setFilter(action: UIAlertAction) {
        // make sure we have a valid image before continuing!
        guard currentImage != nil else { return }

        // safely read the alert action's title
        guard let actionTitle = action.title else { return }

        currentFilter = CIFilter(name: actionTitle)

        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        DispatchQueue.main.async {
            self.applyProcessing()
        }
        
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(slider.value, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(slider.value * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(slider.value * 10, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }
        if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            self.imageView.image = processedImage
        }
    }
    
    
       @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    
    
    }
    
    func Layout(){
        NSLayoutConstraint.activate([
            
            //
             mainView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
             mainView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 5),
             mainView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -5),
             mainView.heightAnchor.constraint(equalToConstant: 450),
             
             //
            imageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            imageView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 440),
            
            //
            slider.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 20),
            slider.leftAnchor.constraint(equalTo: tensityLabel.rightAnchor, constant: 5),
            slider.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -5),
            
            //
            tensityLabel.topAnchor.constraint(equalTo:mainView.bottomAnchor , constant: 23),
            tensityLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0),
            
            //
            changeFilterButton.topAnchor.constraint(equalTo: tensityLabel.bottomAnchor, constant: 10),
            changeFilterButton.leftAnchor.constraint(equalTo: tensityLabel.leftAnchor),
            changeFilterButton.heightAnchor.constraint(equalToConstant: 50),
            changeFilterButton.widthAnchor.constraint(equalToConstant: 120),
            
            //
            
            SaveButton.topAnchor.constraint(equalTo: tensityLabel.bottomAnchor, constant: 10),
            SaveButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -5),
            SaveButton.heightAnchor.constraint(equalToConstant: 70),
            SaveButton.widthAnchor.constraint(equalToConstant: 70)
            
        ])
       
    }

}

