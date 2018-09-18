//
//  SingUp.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/15/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import UIKit
import Alamofire

class SingUpViewController: UIViewController {
    
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
        let alomofireRequest = AlamofireRequestWithParameters (params : parameters, requestedMethod : .post, requestedUrlType : "signup/")
        alomofireRequest.requestDataWithParameters { (response) in
            if response?.success == false {
                self.errorTextField.text = updateTextFieldWithError(errors : (response?.errors)!)
            } else {
                self.accessToken = (response?.data?.accessToken)!
                self.performSegue(withIdentifier: "goToFinalScreenFromSignUp", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFinalScreenFromSignUp" {
            let destinationVC = segue.destination as! FinalViewController
            print(1, accessToken)
            destinationVC.accessToken = accessToken
            print(2, destinationVC.accessToken)
        }
    }
}
