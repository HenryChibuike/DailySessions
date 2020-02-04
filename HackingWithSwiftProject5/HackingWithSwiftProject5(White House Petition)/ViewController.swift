//
//  ViewController.swift
//  HackingWithSwiftProject5(White House Petition)
//
//  Created by Henry-chime chibuike on 2/4/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit


struct Petition: Codable {
    var title: String?
    var body: String?
    var count: Int?
    var people: People?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case body = "body"
        case count = "signatureCount"
    }
    
    init(from decoder: Decoder) {
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        title = try? values.decodeIfPresent(String.self, forKey: .title)
        body = try? values.decodeIfPresent(String.self, forKey: .body)
        count = try? values.decodeIfPresent(Int.self, forKey: .count)
    }
}

enum People: Codable {
    
    
    case number(Int?)
    case string(String?)
    
    init(from decoder: Decoder) throws {
        let value = try! decoder.singleValueContainer()
        do {
            self = try .number(value.decode(Int.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .string(value.decode(String.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Error dedoing people type"))
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string):
            try  container.encode(string)
        case .number(let number):
            try container.encode(number)
        }
    }
}


struct Petitions: Codable {
    var results: [Petition]
}

class ViewController: UITableViewController {
    
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
         
        navigationItem.rightBarButtonItem = .init(title: "Credit", style: .done, target: self, action: #selector(showCredit))
        navigationItem.leftBarButtonItem = .init(title: "Search", style: .done, target: self, action: #selector(Search))
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
            title = "Most Rated"
//            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
            title = "Top Rated"
//            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
            parse(json: data)
            }else{
                showError()
            }
        }else{
            showError()
        }
        
        
    }
    
    
    @objc func showCredit() {
        
        let creditAlert = UIAlertController(title: "This Website is From Hacking With Swift", message: nil, preferredStyle: .alert)
        creditAlert.addAction(UIAlertAction(title: ";)", style: .cancel, handler: nil))
        present(creditAlert, animated: true)
        
    }
    
    @objc func Search() {
        
        let searchAlert = UIAlertController(title: "Search For a Petition", message: nil, preferredStyle: .alert)
        searchAlert.addTextField()
        
        let submitAction = UIAlertAction(title: "Search", style: .default){
            [weak self, weak searchAlert] _ in
            guard let answer = searchAlert?.textFields?[0].text else {return}
            self?.submitSearch(answer)
            print(answer)
            
        }
        searchAlert.addAction(submitAction)
        present(searchAlert, animated: true)
         
    }
    
    func submitSearch(_ answer: String){
        let result = petitions
        self.filteredPetitions.removeAll()
        
        result.forEach({
            if $0.title!.contains(answer) {
                self.filteredPetitions.append($0)
//                print(filteredPetitions)
            }
        })
        tableView.reloadData()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        // here you decode the struct that has var results
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (filteredPetitions.count > 0) ? filteredPetitions.count : petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let petition = (filteredPetitions.count > 0) ? filteredPetitions[indexPath.row] : petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        cell.backgroundColor = .systemBackground
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailedViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

