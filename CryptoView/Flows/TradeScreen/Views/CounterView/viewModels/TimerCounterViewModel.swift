//
//  TimerCounterViewModel.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 26.05.2023.
//

import UIKit
import Combine
import SnapKit

final class TimerCounterViewModel: NSObject, CounterViewModelProtocol {
    
    var newValue = PassthroughSubject<String, Never>()
    var inputTimerValue = PassthroughSubject<Double, Never>()
    
    var showBorder = PassthroughSubject<Bool, Never>()
    private var bag = [AnyCancellable]()
    
    private let validator: KeyboardInputValidator
    
    var title: String
    var clearsOnInsertion = true
    private let formatter: TextFieldFormatter
    private let step = 0.10
    private let parser: TimerParser
    private var currentValue: Double = 0 
    
    init(
        title: String
    ) {
        self.title = title
        self.validator = KeyboardInputValidator()
        self.parser = TimerParser()
        self.formatter = TimerFormatter(parser: parser)
        super.init()
        bind()
    }
    
    func handleCounterButtonTap(_ counter: Counter) {
        let value = counter == .add ? step : -step
        
        let newTimerValue = round((currentValue + value) * 10) / 10.0
        guard !(newTimerValue < step) else { return }
        
        newValue.send(parser.secondsToString(newTimerValue))
    }
}

private extension TimerCounterViewModel {
    func bind() {
        inputTimerValue
            .sink { [weak self] value in
                guard let self = self else { return }
                self.newValue.send(self.parser.secondsToString(value))
                self.currentValue = value
            }.store(in: &bag)
    }
}

extension TimerCounterViewModel: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showBorder.send(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        showBorder.send(false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText: String = textField.text else { return false }
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return validator.isTimerFieldInputValid(updatedText)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text,
              let formattedText = formatter.format(text) else { return }
        let offset = formattedText.count
        let selectedRange = textField.beginningOfDocument
        setSelectedTextRange(textField, from: selectedRange, with: offset)
    }
    
    func textDidChange(_ textField: UITextField) {
        guard let text = textField.text,
              let formattedText = formatter.format(text) else { return }
        set(formattedText, on: textField)
    }
    
    private func set(_ text: String, on textField: UITextField) {
        let offset = text.count
        let selectedRange = textField.beginningOfDocument
        textField.text = text
        currentValue = parser.getSeconds(text)
        setSelectedTextRange(textField , from: selectedRange, with: offset)
    }
    
    private func setSelectedTextRange(_ textField: UITextField, from selectedRange: UITextPosition, with offset: Int) {
        guard let position = textField.position(from: selectedRange, offset: offset) else { return }
        textField.selectedTextRange = textField.textRange(from: position, to: position)
    }
}
