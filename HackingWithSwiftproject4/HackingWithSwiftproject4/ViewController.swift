//
//  ViewController.swift
//  HackingWithSwiftProject4
//
//  Created by Henry-chime chibuike on 2/3/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    
    var errorTitle: String!
    var errorMessage: String!
    var alert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//title = "Anagram"
        navigationController?.navigationBar.prefersLargeTitles = false

        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(newWord))
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .redo, target: self, action: #selector(startGame))
        
        alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
//        print(allWords)
        startGame()
    }

    @objc func newWord(){

        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    func submit( _ answer: String){
        
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    showErrorMessageIsPossible()
                }
            } else {
                
                showErrorMessageIsOriginal()
            }
        } else {
            showErrorMessageIsReal()
        }
        
        
//        present(ac, animated: true)
    }
    
    
    
    // Error Message Handlers
    func showErrorMessageIsPossible(){
        errorTitle = "Word not recognised"
        errorMessage = "You can't just make them up, you know!"
        alert.title = errorTitle
        alert.message = errorMessage
        present(alert, animated: false)
    }
    
    func showErrorMessageIsOriginal(){
        errorTitle = "Word used already"
        errorMessage = "Be more original!"
        alert.title = errorTitle
        alert.message = errorMessage
        present(alert, animated: false)
    }
    
    func showErrorMessageIsReal(){
        guard let title = title?.lowercased() else { return }
        errorTitle = "Word not possible"
        errorMessage = "You can't spell that word from \(title)"
        alert.title = errorTitle
        alert.message = errorMessage
        present(alert, animated: false)
        
    }
    
    func isPossible(word: String) -> Bool {
        
        guard var tempWord = title?.lowercased() else { return false }

           for letter in word {
               if let position = tempWord.firstIndex(of: letter) {
                   tempWord.remove(at: position)
               } else {
                   return false
               }
           }

           return true
    }
    
    

    func isOriginal(word: String) -> Bool {
        
        if word.count <= 3 {
          
            return usedWords.contains(word)
        }
        
        
        if word == title {
     
            return usedWords.contains(word)
        }
        
        return !usedWords.contains(word)
    }

    
    func isReal(word: String) -> Bool {
  let checker = UITextChecker()
     let range = NSRange(location: 0, length: word.utf16.count)
     let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

     return misspelledRange.location == NSNotFound
    
    }
    
    
}
    


