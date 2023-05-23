//
//  UINavigationController+Ext.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 20.05.2023.
//

import UIKit

extension UINavigationController {
    class func buildAsRootForWindow(_ window: UIWindow?) -> UINavigationController {
        window?.rootViewController = UINavigationController()
        window?.rootViewController?.view.backgroundColor = .white
        guard let controller = window?.rootViewController as? UINavigationController
        else { return UINavigationController() }
        return controller
    }
}
