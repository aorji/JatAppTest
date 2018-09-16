//
//  FinalViewController.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import UIKit




class FinalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var tabelView: UITableView!
    
    var accessToken : String!
    let myText = "here is my text"
    var result = [Character : Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        result = self.countCharacter(text: myText)
    }
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func countCharacter(text: String) -> [Character:Int]{
        
        var dictionary = [Character : Int]()
        
        for item in text {
            if let _ = dictionary[item] {
                dictionary[item]! += 1
            } else {
                dictionary[item] = 1
            }
        }
        return dictionary
    }
    
    //updateTabelWithAnAnswer
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        for (index, value) in result.enumerated() {
            if index == indexPath.row {
                var word = ""
                if value.value == 1 {
                    word = " time"
                } else {
                    word = " times"
                }
                cell.textLabel?.text = "'\(value.key)'" + " - " + "\(value.value)" + "\(word)"
            }
        }
        return cell
    }
    
}
