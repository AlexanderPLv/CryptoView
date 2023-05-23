//
//  Spacer.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import UIKit

final class VSpacer: UIView {
    
    init(_ height: CGFloat?) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        if let height = height {
            heightAnchor.constraint(
                equalToConstant: height
            ).setActiveBreakable()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class HSpacer: UIView {
    
    init(_ width: CGFloat?) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        if let width = width {
            widthAnchor.constraint(
                equalToConstant: width
            ).setActiveBreakable()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
