//
//  Colors.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 20.05.2023.
//

import UIKit

enum Color {
    enum TabBar {
        static let background = UIColor().hex(0x20232F).withAlphaComponent(0.2)
        static let border = UIColor().hex(0x20232F)
    }
    enum Common {
        static let background = UIColor().hex(0x1C1F2D)
        static let red = UIColor().hex(0xFE3D43)
        static let darkGray = UIColor().hex(0x333749)
        static let lightGreen = UIColor().hex(0x35B972)
        static let lightGray = UIColor().hex(0x5B5A60)
        static let lightGrayText = UIColor().hex(0xC1C2C8)
        static let listCellBackground = UIColor().hex(0x2E303E)
    }
}
