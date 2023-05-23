//
//  NSLayoutConstraint+Ext.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import UIKit

public extension NSLayoutConstraint {
    @objc func setActiveBreakable(
        priority:UILayoutPriority = UILayoutPriority(900)
    ) {
        self.priority = priority
        isActive = true
    }
}
