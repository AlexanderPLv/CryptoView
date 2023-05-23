//
//  UICollectionView+Ext.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import Foundation

import UIKit

protocol ReusableView: NSObjectProtocol {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension UICollectionViewCell: ReusableView {}
