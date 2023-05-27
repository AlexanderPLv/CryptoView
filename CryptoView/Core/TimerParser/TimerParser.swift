//
//  TimerParser.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 27.05.2023.
//

import Foundation

final class TimerParser {
    
    func getSeconds(_ string: String) -> Double {
        guard !string.isEmpty else { return 0 }
        let secondsString = string.replacingOccurrences(of: ":", with: ".")
        guard let seconds = Double(secondsString) else { return 0 }
        guard seconds <= 99.0 else { return 99.0 }
        return round(seconds * 10) / 10.0
    }
    
    func secondsToString(_ seconds: Double) -> String {
        let rounded = round(seconds * 10) / 10.0
        let fract = modf(seconds).1
        let roundedFract = round(fract * 10) / 10.0
        let decimal = Int(roundedFract * 10)
        let wholeSeconds = Int(rounded)
        var secondsString = String(wholeSeconds)
        if seconds < 10 {
            secondsString = "0" + secondsString
        }
        let decimalString = String(decimal * 10)
        return secondsString + decimalString
    }
}
