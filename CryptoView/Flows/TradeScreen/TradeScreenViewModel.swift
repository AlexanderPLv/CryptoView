//
//  TradeScreenViewModel.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import UIKit

struct TradeScreenViewModel {
    
    private var balance = 10000
    private let investmentStep = 100
    
    let timerObserver: TextFieldObserver
    let investmentObserver: TextFieldObserver
    
    init(
        timerObserver: TextFieldObserver,
        investmentObserver: TextFieldObserver
    ) {
        self.timerObserver = timerObserver
        self.investmentObserver = investmentObserver
    }
    
    func getBalance() -> Int {
        balance
    }
    
    func changeTimerValue(_ counter: Counter) {
        
    }
    
    func changeInvestmentAmount(_ counter: Counter) {
        let value = counter == .add ? investmentStep : -investmentStep
        investmentObserver.update(with: value)
    }
    
    func currentCurrencyPair() -> String {
        "GPB/USD"
    }
    
}
