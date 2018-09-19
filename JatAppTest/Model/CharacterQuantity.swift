//
//  CharacterQuantity.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/19/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import Foundation

//Count occurrence of each character (printable/unprintable) in the text

func countCharacter(text: String) -> [CharacterQuantity] {
    var dictionary = [Character : Int]()
    
    for item in text {
        if let _ = dictionary[item] {
            dictionary[item]! += 1
        } else {
            dictionary[item] = 1
        }
    }
    return castDictionaryToArray(dictionary: dictionary)
}

func castDictionaryToArray(dictionary :  [Character : Int]) -> [CharacterQuantity]{
    
    var characterQuantityArray = [CharacterQuantity]()
    
    for (_, value) in dictionary.enumerated() {
        characterQuantityArray.append(CharacterQuantity(item: value.key, quantity: value.value))
    }
    return characterQuantityArray
}

