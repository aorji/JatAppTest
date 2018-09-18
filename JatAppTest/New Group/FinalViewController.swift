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
    var textFromRequest = "hh"
    var characterQuantityArray = [CharacterQuantityStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create request with token, get text
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer " + accessToken
        ]
        Alamofire.request ("https://apiecho.cf/api/get/text/", method: .get, headers: headers)
            .responseJSON { response in
                do {
                    let responseData = response.data
                    let responseDataValue = try JSONDecoder().decode(ResponseWithToken.self, from: responseData!)
                    if responseDataValue.success == false {
                       print(responseDataValue.errors) // A ТУТ СЛОВАРЬ, А НЕ СТРОКА, ШО БУДЕМ ДЕЛАТЬ?
                    } else {
//                        print(responseDataValue.data)
                        self.countCharacter(text: responseDataValue.data)
                        self.tableView.reloadData()
                    }
                }
                catch let error {print(error)}
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
        cell.textLabel?.text = "\(characterQuantityArray[indexPath.row].item)"  + " - " + "\(characterQuantityArray[indexPath.row].quantity)" + "\(word)"
        return cell
    }
    
}
