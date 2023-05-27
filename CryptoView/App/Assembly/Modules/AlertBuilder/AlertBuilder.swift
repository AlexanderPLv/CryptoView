//
//  AlertBuilder.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import UIKit

protocol AlertBuilderProtocol {
    func buildErrorAlert(message: String, completionHandler: CompletionBlock?) -> UIAlertController
    func buildSuccessAlert(completionHandler: CompletionBlock?) -> UIAlertController
}

extension ModulesFactory: AlertBuilderProtocol {
    func buildErrorAlert(message: String, completionHandler: CompletionBlock?) -> UIAlertController {
        let controller = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Ok", style: .destructive) { _ in
            completionHandler?()
        } )
        return controller
    }
    
    func buildSuccessAlert(completionHandler: CompletionBlock?) -> UIAlertController {
        let controller = UIAlertController(title: "Successfully", message: nil, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            completionHandler?()
        } )
        return controller
    }
}
