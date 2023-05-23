//
//  Formatter+Ext.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}
