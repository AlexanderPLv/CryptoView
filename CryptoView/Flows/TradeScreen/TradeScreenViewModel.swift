//
//  TradeScreenViewModel.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import UIKit
import Foundation
import Combine

final class TradeScreenViewModel {
    
    var balance = PassthroughSubject<Int, Never>()
    var updateTimer = PassthroughSubject<Double, Never>()
    var updateInvestment = PassthroughSubject<Int, Never>()
    var success = PassthroughSubject<Void, Never>()
    
    private var model = UserModel()
    private var timerValue = 0.1
    
    init() {}
    
    func sell() {
        guard model.balance > model.investment else { return }
        let investment = model.investment
        let value = model.balance - investment
        success.send()
        model.balance = value
        if investment > value {
            model.investment = model.balance
            updateInvestment.send(model.investment)
        }
        if Bool.random() {
            model.balance += Int(Double(model.investment) * 1.7)
        }
        balance.send(model.balance)
    }
    
    func setInitialValues() {
        balance.send(model.balance)
        updateTimer.send(timerValue)
        updateInvestment.send(model.investment)
    }
    
    func currentCurrencyPair() -> CurrencyPair {
        model.selectedPair
    }
    
    func setSelectedPair(_ pair: CurrencyPair) {
        model.selectedPair = pair
    }
    
    func investmentAmount() -> Double {
        Double(model.investment)
    }
    
    func setInvestmentAmount(_ value: Int) {
        model.investment = value
    }
}
