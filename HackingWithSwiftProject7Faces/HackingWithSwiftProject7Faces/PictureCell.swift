//
//  PictureCell.swift
//  HackingWithSwiftProject7Faces
//
//  Created by Henry-chime chibuike on 2/6/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit

class PictureCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(white: 0.96, alpha: 1)
        layer.cornerRadius = 16
        layer.borderWidth = 0.01
        layer.borderColor = UIColor.black.cgColor
        
//        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 16
//        imageView.contentMode = .scaleAspectFill
        label.text = "Label"
        label.textAlignment = .center
        
        addSubview(imageView)
        addSubview(label)
        
//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
//        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: 10).isActive = true
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
