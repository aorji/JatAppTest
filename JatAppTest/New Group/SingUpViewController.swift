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
        getAccessToFinalScreen(parameters: param)
    }
    
    func getAccessToFinalScreen(parameters : [String : String]) {
        let alomofireRequest = AlamofireRequest (params : parameters, requestedMethod : .post, requestedUrlType : "signup/")
        alomofireRequest.requestDataWithParameters { [weak self] (response) in
            if response?.success == false {
                self?.errorTextField.text = updateTextFieldWithError(errors : (response?.errors)!)
            } else {
                self?.accessToken = (response?.data?.accessToken)!
                self?.performSegue(withIdentifier: "goToFinalScreenFromSignUp", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFinalScreenFromSignUp" {
            guard let destinationVC = segue.destination as? FinalViewController else {
                return
            }
            destinationVC.accessToken = accessToken
        }
    }
}
