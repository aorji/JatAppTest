//
//  UpdateErrorTextField.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import Foundation

func updateTextFieldWithError(errors : [Error]) -> String {
    
    var errorMessage = ""
    
    for message in errors {
        errorMessage = errorMessage + "\n" +  String(describing: message.message)
    }
    return errorMessage
}
