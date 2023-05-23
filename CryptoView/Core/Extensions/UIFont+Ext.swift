//
//  UIFont+Ext.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import UIKit

extension UIFont {
    enum Inter {
        static func extraBold(ofSize: CGFloat) -> UIFont {
            return UIFont(name: "Inter-ExtraBold", size: ofSize)!
        }
        static func bold(ofSize: CGFloat) -> UIFont {
            return UIFont(name: "Inter-Bold", size: ofSize)!
        }
        static func medium(ofSize: CGFloat) -> UIFont {
            return UIFont(name: "Inter-Medium", size: ofSize)!
        }
    }
}
