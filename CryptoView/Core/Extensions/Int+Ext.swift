//
//  Int+Ext.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import Foundation

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
