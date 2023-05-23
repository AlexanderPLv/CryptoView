//
//  TopListCellItem.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import Foundation

struct TopListCellItem: Hashable {
    var index = 1
    let name: String
    var deposit: Int
    var profit: Int
    let country: String
    
    func depositAsString() -> String {
        "$" + "\(deposit)"
    }
    
    func profitAsString() -> String {
        "$" + "\(profit)"
    }
}
