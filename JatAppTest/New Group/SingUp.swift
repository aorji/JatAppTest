//
//  SingUp.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/15/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SingUp: UIViewController {

    let url =  "https://apiecho.cf/api/signup/"
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorTextField.text = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        let param : [String : String] = ["name" : username.text!, "email" : email.text!, "password" : password.text!]
        
        pushData(parameters: param)
        
    }
    
    func pushData(parameters : [String : String]) {
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("success request")
                let resultJSON : JSON = JSON(response.result.value!)
                print(resultJSON)
                if resultJSON["success"].boolValue == false {
                    self.updateTextFieldWithError(json : resultJSON)
                } else {self.saveToken(json : resultJSON)}
            }
            else {
                print("Error request")
            }
        }
    }
    
    func updateTextFieldWithError(json : JSON) {
        
        var errorMessage = ""
        
        for (_, error) in json["errors"] {
            errorMessage = errorMessage + "\n" +  String(describing: error["message"])
        }
        errorTextField.text = errorMessage
    }

    func saveToken(json : JSON) {
        let accessToken = json["data"]["access_token"]
        print(accessToken)
    }
}
