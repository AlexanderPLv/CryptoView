//
//  Presentable.swift
//  RoxieTest
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import UIKit

protocol Presentable {
    var toPresent: UIViewController? { get }
}
 
extension UIViewController: Presentable {
    var toPresent: UIViewController? {
        return self
    }
}
