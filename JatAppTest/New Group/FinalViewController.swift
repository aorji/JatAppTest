//
//  FinalViewController.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import UIKit




class FinalViewController: UIViewController {

    var accessToken : String!
    @IBOutlet weak var tokenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenLabel.text = accessToken
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //getText
    let text = "here is my text"
    
    func countCharacter(text: String) -> [Character:Int]{
        
        var dictionary : [Character : Int] = [:]
        
        for item in text {
            if let _ = dictionary[item] {
                dictionary[item]! += 1
            } else {
                dictionary[item] = 1
            }
            text.dropFirst()
        }
        return (dictionary)
    }
    
    //updateTabelWithAnswer
    
}
