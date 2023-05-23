//
//  TextFieldTimerFormatter.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import UIKit

protocol TextFieldFormatter {
    var placeholder: String { get }
    func format(_ text: String) -> String
    func format(_ text: String, with newValue: Int) -> Int
    func fillEndWithMask(_ string: String) -> String
}

final class TimerFormatter: TextFieldFormatter {
    func format(_ text: String, with newValue: Int) -> Int {
        return 0
    }
    
    var placeholder = "00:01"
    private let mask = "__:__"
    
    func updateValue(by counter: Counter) {
        
    }
    
    func format(_ text: String) -> String {
        let numbers = text.components(
            separatedBy: CharacterSet.decimalDigits.inverted
        ).joined()
        print(numbers)
        var result = ""
        var index = numbers.startIndex
        for ch in mask {
            if index == numbers.endIndex {
                break
            }
            if ch == "_" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func fillEndWithMask(_ string: String) -> String {
        var text = string
        var count = text.count
        
        let mask = mask as NSString
        while (count < mask.length) {
            let unichar = mask.character(at: count)
            let unicharString = Character(UnicodeScalar(unichar)!)
            text.append(unicharString)
            count += 1
        }
        return text
    }
}


