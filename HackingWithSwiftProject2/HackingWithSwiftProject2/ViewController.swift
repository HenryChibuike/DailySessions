//
//  ViewController.swift
//  HackingWithSwiftProject2
//
//  Created by Henry-chime chibuike on 1/30/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var Score = 0
    var correctAnswer = 0
    var counter: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain","uk", "us"]
        
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestions()
    }
    
    func askQuestions(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) Score:\(Score)"
      
        
    }
    

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            Score += 1
            self.counter += 1
        }else {
            title = "In Correct"
            Score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(Score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "continue", style: .default, handler: { _ in
            if self.counter > 2 {
                self.endgame()
                return
            }
            self.askQuestions()
        }))
        // in here for your handler do not call it as a function
        present(ac, animated: true)
        
    }
    
    func endgame() {
        let end = UIAlertController(title: "Score: \(Score) / " + String(counter) + "/n Do You Want To Play Again" , message: "Game Over", preferredStyle: .alert)
        
        end.addAction(UIAlertAction(title:"Yes" , style: .default, handler: { _ in
            self.counter = 0
            self.Score = 0
            
            self.askQuestions()
            
        }))
        present(end, animated: true)
        
        end.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
            self.endgame()
        }))
        
    }

}
