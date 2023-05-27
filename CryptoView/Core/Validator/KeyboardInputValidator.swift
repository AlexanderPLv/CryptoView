//
//  KeyboardInputValidator.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 25.05.2023.
//

import Foundation
import Combine

struct KeyboardInputValidator {
    
    var currentBalance = CurrentValueSubject<Int, Never>(0)
    
    func isInvestmentFieldInputValid(_ input: String) -> Bool {
        guard !input.isEmpty else { return true }
        let numbersString = input.components(
            separatedBy: CharacterSet.decimalDigits.inverted
        ).joined()
        guard let value = Int(numbersString), value <= currentBalance.value else {
            return false
        }
        return true
    }
    
    func isTimerFieldInputValid(_ input: String) -> Bool {
        return true
    }
}
