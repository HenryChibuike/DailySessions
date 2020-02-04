//
//  ListController.swift
//  brianVoong
//
//  Created by Henry-chime chibuike on 1/17/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import LBTATools

// creating a model to make the app more dynamic
struct Message {
    let UserProfileImage, Username, Text : String
}

// this is the list cell which will be passed into the main list cell controlelr
class MessageCell: LBTAListCell<Message>{
    //creating ui elements
    let Image = UIImageView(backgroundColor: .gray)
    let Namelabel = UILabel(text: "UserName", font: .boldSystemFont(ofSize: 16), textColor: .black)
    let messageLabel = UILabel(text: "programming using lbta is soo nice wait its even beyond mad you can stack things up with ease bro you dont even get", font: .boldSystemFont(ofSize: 12), textColor: .black, numberOfLines: 100000)

    override var item: Message!{
        didSet{
            Namelabel.text = item.Username
            messageLabel.text = item.Text
            Image.image = UIImage(named: item.UserProfileImage)
            
            
        }
    }
    
    // this function is to avoid init override
    override func setupViews() {
        super.setupViews()
        
        Image.contentMode = .scaleAspectFill
        Image.clipsToBounds = true
        Image.layer.borderWidth = 0.55
        Image.layer.cornerRadius = 65/2
        // when using your image always align so that you can adjust your image height and width
        hstack(Image.withWidth(65).withHeight(65)
            ,stack(Namelabel,messageLabel, spacing: 8), spacing: 8,
             alignment: .center).withMargins(.allSides(16))
        
        addSeparatorView(leadingAnchor: Namelabel.leadingAnchor)
    }
}

// this will contain the cell and the list which is the ui color
// using this list controller we avoid alot of coding like
// 1 collectionview.register
//number of items
//cellforindexpath and cell id
class MessageController: LBTAListController<MessageCell, Message>, UICollectionViewDelegateFlowLayout{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [
//            .init(UserProfileImage: "layo", Username: "Baby Layo ", Text: "hey from this side coding and stuff"),
            
            .init(UserProfileImage: "chibuike", Username: "Chibuike", Text: "Free UnknownT"),
            
            .init(UserProfileImage: "unknownT", Username: "Homerton B", Text: "Samurais in Batches"),
            
            .init(UserProfileImage: "Arms", Username: "Mad about Weights", Text: "Till we fucking Die")
        ]
        
        navigationItem.rightBarButtonItem = .init(title: "Log out", style: .plain, target: self, action: #selector(Logout))
        
    }
    
    @objc func Logout(){
        
        let NewLogout = HomeController()
        NewLogout.modalPresentationStyle = .fullScreen
        present(NewLogout, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
}
    
    

    

