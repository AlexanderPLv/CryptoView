//
//  TextFieldInvestmentFormatter.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import UIKit

final class TextFieldInvestmentFormatter: TextFieldFormatter {
    
    var placeholder = "1,000"
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func format(_ text: String, with newValue: Int) -> Int {
        let numbersString = text.components(
            separatedBy: CharacterSet.decimalDigits.inverted
        ).joined()
        guard let num = Int(numbersString) else { return 0 }
        return num + newValue
    }
    
    func format(_ text: String) -> String {
        let numbersString = text.components(
            separatedBy: CharacterSet.decimalDigits.inverted
        ).joined()
        guard let numbers = Int(numbersString),
              let result = numberFormatter.string(for: numbers) else { return text}
        return result
    }

    func fillEndWithMask(_ string: String) -> String {
        return string
    }
}
