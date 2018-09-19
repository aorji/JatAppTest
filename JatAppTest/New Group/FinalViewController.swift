//
//  FinalViewController.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import UIKit
import Alamofire

struct CharacterQuantity {
    let item : Character
    let quantity : Int
}

class FinalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var accessToken : String!
    var textFromRequest = ""
    var characterQuantityArray = [CharacterQuantity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer " + accessToken
        ]
        let alomofireRequest = AlamofireRequest (requestedMethod : .post, requestedUrlType : "get/text/", headers: headers)
        alomofireRequest.requestDataWithHeader {[weak self] (response) in
            if response?.success == true {
                self?.characterQuantityArray = countCharacter(text: (response?.data)!)
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
