//
//  InvestmentCounterViewModel.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import UIKit
import Combine

protocol CounterViewModelProtocol: UITextFieldDelegate {
    var title: String { get }
    var clearsOnInsertion: Bool { get }
    func textDidChange(_ textField: UITextField)
    func handleCounterButtonTap(_ counter: Counter)
    var showBorder: PassthroughSubject<Bool, Never> { get }
    var newValue: PassthroughSubject<String, Never> { get }
}

final class InvestmentCounterViewModel: NSObject, CounterViewModelProtocol {
    
    var showBorder = PassthroughSubject<Bool, Never>()
    var balance = CurrentValueSubject<Int, Never>(0)
    var inputInvestmentValue = PassthroughSubject<Int, Never>()
    var outputInvestmentValue = PassthroughSubject<Int, Never>()
    var newValue = PassthroughSubject<String, Never>()
    private var bag = [AnyCancellable]()
    
    private let validator: KeyboardInputValidator
    private var investmentAmount: Int
    
    var title: String
    var clearsOnInsertion = false
    private var formatter: TextFieldFormatter
    private let step: Int
    
    init(
        title: String,
        step: Int
    ) {
        self.investmentAmount = 0
        self.title = title
        self.validator = KeyboardInputValidator()
        self.formatter = TextFieldInvestmentFormatter()
        self.step = step
        super.init()
        bind()
    }
    
    func handleCounterButtonTap(_ counter: Counter) {
        let value = counter == .add ? step : -step
        
        let newInvestmentAmount = investmentAmount + value
        guard !(newInvestmentAmount < 0), !(newInvestmentAmount > balance.value) else { return }
        
        outputInvestmentValue.send(newInvestmentAmount)
        investmentAmount = newInvestmentAmount
        newValue.send(String(investmentAmount))
    }
}

private extension InvestmentCounterViewModel {
    func bind() {
        balance.subscribe(validator.currentBalance)
            .store(in: &bag)
        
        inputInvestmentValue
            .sink { [weak self] value in
                self?.investmentAmount = value
                self?.newValue.send(String(value))
            }.store(in: &bag)
    }
}

extension InvestmentCounterViewModel: UITextFieldDelegate {
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
        return validator.isInvestmentFieldInputValid(updatedText)
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
        if let value = Int(formatter.removeMask(text)) {
            textField.text = text
            setSelectedTextRange(textField , from: selectedRange, with: offset)
            outputInvestmentValue.send(value)
            investmentAmount = value
        } else {
            investmentAmount = 0
            outputInvestmentValue.send(0)
        }
    }
    
    private func setSelectedTextRange(_ textField: UITextField, from selectedRange: UITextPosition, with offset: Int) {
        guard let position = textField.position(from: selectedRange, offset: offset) else { return }
        textField.selectedTextRange = textField.textRange(from: position, to: position)
    }
}
