//
//  HomeController.swift
//  brianVoong
//
//  Created by Henry-chime chibuike on 1/16/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import LBTATools
class HomeController: LBTAFormController {
    
    let ImageView = UIImageView(image: #imageLiteral(resourceName: "21-211117_amped-logo-cool-discord-server-icons"), contentMode: .scaleAspectFit)
    let name = IndentedTextField(placeholder: "Full Name", padding: 12, cornerRadius:5 , backgroundColor: .white)
    let email = IndentedTextField(placeholder: "Email", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let username = IndentedTextField(placeholder: "Username", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let password = IndentedTextField(placeholder: "Password", padding: 12, cornerRadius: 5,backgroundColor: .white, isSecureTextEntry: true)
    
    let SignUpButton = UIButton(title: "Sign Up", titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: .boldSystemFont(ofSize: 14), backgroundColor: .blue, target: self, action: #selector(handleButton))
    
    let CancelButton = UIButton(title: "Cancel", titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: .boldSystemFont(ofSize: 14), backgroundColor: .red, target: self, action: #selector(handleButton))
    
    @objc func handleButton(){
        
        let newView = UINavigationController.init(rootViewController: MessageController())
        newView.modalPresentationStyle = .fullScreen // to make full screen
        present(newView, animated: true)
//        dismiss(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(white:0.96, alpha:1)
        
        email.autocorrectionType = .no
        SignUpButton.layer.cornerRadius = 5
        CancelButton.layer.cornerRadius = 5
        
        // giiving height
        [name,email,username,password,SignUpButton,CancelButton].forEach{$0.constrainHeight(50)}
        ImageView.constrainHeight(64)
        
        StackSetUp()
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        

        }
    
    func StackSetUp(){
        
        formContainerStackView.stack(
            ImageView,name,email,username,password,SignUpButton,CancelButton, spacing:16
        ).withMargins(.init(top: 50, left: 16, bottom: 16, right: 16))
    }
//    dismiss keyboard when you click a safe area
    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
    }
    }

