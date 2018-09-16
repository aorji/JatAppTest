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
        
        requestData(parameters: param)
    }
    
    func requestData(parameters : [String : String]) {
        let alomofireRequest = AlamofireRequest(params : parameters, requestMethod : .post, requestUrlType : "signup/")
        alomofireRequest.requestData { (response) in
            if response?.success == false {
                self.updateTextFieldWithError(errors : (response?.errors)!)
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
