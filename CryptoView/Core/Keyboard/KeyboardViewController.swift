//
//  KeyboardViewController.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import UIKit

class KeyboardViewController: UIViewController {
    var hideKeyboardOnClick = true
    var cancelsTouchesInView = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if hideKeyboardOnClick {
            let tapRecognizer = UITapGestureRecognizer()
            tapRecognizer.cancelsTouchesInView = cancelsTouchesInView
            tapRecognizer.addTarget(self, action: #selector(didTapView))
            view.addGestureRecognizer(tapRecognizer)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterFromKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size ?? .zero
        keyboardSizeChanged(size: keyboardSize)
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        keyboardSizeChanged(size: .zero)
    }
    
    func keyboardSizeChanged(size: CGSize) {
        
    }
    
    @objc func didTapView() {
        view.endEditing(true)
    }
}
