//
//  TextFieldObserver.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import UIKit
import Combine

final class TextFieldObserver: NSObject {
    
   // var newValue: PassthroughSubject
    
    private weak var textField: UITextField?
    private var formatter: TextFieldFormatter
    
    init(
        formatter: TextFieldFormatter
    ) {
        self.formatter = formatter
        super.init()
    }
    
    func update(with value: Int) {
        if let textField = textField {
            let text = text(from: textField)
            let newValue = formatter.format(text, with: value)
        }
    }
    
    func addObservable(_ textField: UITextField) {
        self.textField = textField
        self.textField?.text = formatter.placeholder
        self.textField?.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.textField?.addTarget(self, action: #selector(self.didBeginEditing(textField:)), for: .editingDidBegin)
    }
    
}

private extension TextFieldObserver {
    
    @objc func didBeginEditing(textField: UITextField) {
        guard let text = textField.text else { return }
        let formattedText = formatter.format(text)
        let offset = formattedText.count
        let selectedRange = textField.beginningOfDocument
        setSelectedTextRange(from: selectedRange, with: offset)
    }

    @objc func textDidChange() {
         if let textField = textField {
            let text = text(from: textField)
            let formattedText = formatter.format(text)
            set(formattedText)
        }
    }

    func text(from textField: UITextField) -> String {
        guard let text = textField.text else { return "" }
        return text
    }

    private func set(_ text: String) {
        guard let textField = textField else { return }
        let formattedText = formatter.format(text)
        let offset = formattedText.count
        let selectedRange = textField.beginningOfDocument
        let maskedText = formatter.fillEndWithMask(formattedText)
        textField.text = maskedText
        setSelectedTextRange(from: selectedRange, with: offset)
    }

    func setSelectedTextRange(from selectedRange: UITextPosition, with offset: Int) {
        if let textField = textField,
           let position = textField.position(from: selectedRange, offset: offset) {
            textField.selectedTextRange = textField.textRange(from: position, to: position)
        }
    }
}
