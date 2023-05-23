//
//  UIView+Ext.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import UIKit

extension UIView {
    
    func blink(
        withDuration: CGFloat = 0.1,
        currentAlpha: CGFloat = 1.0,
        completion: (() -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: withDuration,
            delay: 0.0,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                self?.alpha = 0.5
            },
            completion: { [weak self] _ in
                self?.alpha = currentAlpha
                completion?()
            }
        )
    }
}
