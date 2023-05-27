//
//  CurrencyPair.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 23.05.2023.
//

import Foundation

enum CurrencyPair: String, CaseIterable {
    case eurusd = "EUR/USD"
    case gpbusd = "GPB/USD"
    case usdjpy = "USD/JPY"
    case gpbjpy = "GPB/JPY"
    case eurjpy = "EUR/JPY"
    case eurgpb = "EUR/GPB"
    case audusd = "AUD/USD"
    case audjpy = "AUD/JPY"
    case usdcad = "USD/CAD"
    case usdchf = "USD/CHF"
}

extension CurrencyPair {
    var requestSymbol: String {
        switch self {
        case .eurusd:
            return "FX:EURUSD"
        case .gpbusd:
            return "FX:GBPUSD"
        case .usdjpy:
            return "FX:USDJPY"
        case .gpbjpy:
            return "FX:GBPJPY"
        case .eurjpy:
            return "FX:EURJPY"
        case .eurgpb:
            return "FX:EURGBP"
        case .audusd:
            return "FX:AUDUSD"
        case .audjpy:
            return "FX:AUDJPY"
        case .usdcad:
            return "FX:USDCAD"
        case .usdchf:
            return "FX:USDCHF"
        }
    }
}
