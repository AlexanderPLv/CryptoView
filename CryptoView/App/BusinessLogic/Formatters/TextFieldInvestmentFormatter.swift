//
//  TextFieldInvestmentFormatter.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import UIKit

final class TextFieldInvestmentFormatter: TextFieldFormatter {
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func format(_ text: String) -> String? {
        if text.isEmpty {
            return "0"
        }
        let string = text.components(
            separatedBy: CharacterSet.decimalDigits.inverted
        ).joined()
        guard let result = numberFormatter.string(for: Int(string)) else { return nil }
        return result
    }

    func fillEndWithMask(_ string: String) -> String {
        return string
    }
    
    func removeMask(_ text: String) -> String {
        let result = text.components(
            separatedBy: CharacterSet.decimalDigits.inverted
        ).joined()
        return result
    }
}
