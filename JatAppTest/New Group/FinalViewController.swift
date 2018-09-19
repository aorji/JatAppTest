//
//  FinalViewController.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import UIKit
import Alamofire

struct CharacterQuantityStruct {
    let item : Character
    let quantity : Int
}

class FinalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var accessToken : String!
    var textFromRequest = ""
    var characterQuantityArray = [CharacterQuantityStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(accessToken)
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer " + accessToken
        ]
        let alomofireRequest = AlamofireRequest (requestedMethod : .post, requestedUrlType : "get/text/", headers: headers)
        alomofireRequest.requestDataWithHeader {(response) in
            if response?.success == true {
                self.countCharacter(text: (response?.data)!)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    //Count occurrence of each character (printable/unprintable) in the text
    func countCharacter(text: String){
        var dictionary = [Character : Int]()
        
        for item in text {
            if let _ = dictionary[item] {
                dictionary[item]! += 1
            } else {
                dictionary[item] = 1
            }
        }
       castDictionaryToArray(dictionary: dictionary)
    }
    
    
    func castDictionaryToArray(dictionary :  [Character : Int]){
        for (_, value) in dictionary.enumerated() {
            characterQuantityArray.append(CharacterQuantityStruct(item: value.key, quantity: value.value))
        }
    }
    
    //Display results using UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterQuantityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        var word = " times"
        if characterQuantityArray[indexPath.row].quantity == 1 {
            word = " time"
        }
        cell.textLabel?.text = "'\(characterQuantityArray[indexPath.row].item)'"  + " - " + "\(characterQuantityArray[indexPath.row].quantity)" + "\(word)"
        return cell
    }
    
}
