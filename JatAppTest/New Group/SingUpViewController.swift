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
    
    var accessToken = ""
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorTextField.text = ""
    }
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        let param : [String : String] = ["name" : username.text!, "email" : email.text!, "password" : password.text!]
        getEccessToFinalScreen(parameters: param)
    }
    
    func getEccessToFinalScreen(parameters : [String : String]) {
        let alomofireRequest = AlamofireRequest(params : parameters, requestMethod : .post, requestUrlType : "signup/")
        alomofireRequest.requestData {(response) in
            if response?.success == false {
                self.updateTextFieldWithError(errors : (response?.errors)!)
            } else {
                self.accessToken = (response?.data?.accessToken)!
                self.performSegue(withIdentifier: "goToFinalScreen", sender: self)
            }
        }
    }
    
    func updateTextFieldWithError(errors : [Error]) {
        
        var errorMessage = ""
        
        for message in errors {
            errorMessage = errorMessage + "\n" +  String(describing: message.message)
        }
        errorTextField.text = errorMessage
    }
}
