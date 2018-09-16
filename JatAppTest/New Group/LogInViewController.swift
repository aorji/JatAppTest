//
//  LogIn.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/15/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LogIn: UIViewController {

    let url =  "https://apiecho.cf/api/login/"
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorTextField: UITextView!
    
//    var userLoginIsAllowed : Bool = false
    
    override func viewDidLoad() {
        errorTextField.text = ""
        super.viewDidLoad()

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
        let param : [String : String] = ["email" : email.text!, "password" : password.text!]
        requestData(parameters: param)
    }
    
    func requestData(parameters : [String : String]) {
        let alomofireRequest = AlamofireRequest(params : parameters, requestMethod : .post, requestUrlType : "login/")
        alomofireRequest.requestData { (response) in
            if response?.success == false {
                self.updateTextFieldWithError(errors : (response?.errors)!)
            }
//            else {
//                userLoginIsAllowed = true
//            }
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
