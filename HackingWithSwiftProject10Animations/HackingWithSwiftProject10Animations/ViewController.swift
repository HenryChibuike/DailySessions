//
//  ViewController.swift
//  HackingWithSwiftProject10Animations
//
//  Created by Henry-chime chibuike on 2/11/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let Button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Tap", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.addTarget(self, action: #selector(TappedButtonAction), for: .touchUpInside)
        return btn
    }()
    
    var imageView: UIImageView!
    var currentAnimation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(Button)
        buttonLayout()
        
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
        
    }
    
    @objc func TappedButtonAction(){
        print("Tapped")
        Button.isHidden = true
        
        // this animates the view
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
                       animations: {
                        switch self.currentAnimation {
                        case 0:
                            // increase image size
                            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                        case 1:
                            // identity means go back to normal state or reset
                            self.imageView.transform = .identity
                        case 2:
                            self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
                            
                        case 3:
                            self.imageView.transform = .identity
                            
                        case 4:
                            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                        
                        case 5:
                            self.imageView.transform = .identity
                            
                        case 6:
                            self.imageView.alpha = 0.1
                            self.imageView.backgroundColor = UIColor.green
                            
                        case 7:
                            self.imageView.alpha = 1
                            self.imageView.backgroundColor = UIColor.clear
                            
                        default:
                            break
                        }
        }) { finished in
            self.Button.isHidden = false
        }
        
        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
    
    func buttonLayout(){
        NSLayoutConstraint.activate([
        Button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -30),
        Button.heightAnchor.constraint(equalToConstant: 50),
        Button.widthAnchor.constraint(equalToConstant: 50),
        Button.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor, constant: -30)
            
        ])
    }
}

