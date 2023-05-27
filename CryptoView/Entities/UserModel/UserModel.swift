//
//  UserModel.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import Foundation

struct UserModel {
    var balance = 10000
    var investment = 1000
    let investmentStep = 100
    var selectedPair = CurrencyPair.allCases.first!
}
