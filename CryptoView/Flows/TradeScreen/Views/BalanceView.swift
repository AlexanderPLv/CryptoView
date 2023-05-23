//
//  BalanceView.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import UIKit
import SnapKit

final class BalanceView: UIView {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.medium(ofSize: 12.0)
        view.textColor = Color.Common.lightGrayText
        view.numberOfLines = 1
        view.text = "Balance"
        view.textAlignment = .center
        return view
    }()
    
    private let amountLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16.0)
        view.textColor = .white
        view.numberOfLines = 1
        view.textAlignment = .center
        return view
    }()
    
    init(amount: Int) {
        self.amountLabel.text = amount.formattedWithSeparator
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension BalanceView {
    
    func setupView() {
        backgroundColor = Color.Common.darkGray
        layer.cornerRadius = 12.0
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5.0)
            make.centerX.equalToSuperview()
        }
        addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(7.0)
            make.centerX.equalToSuperview()
        }
    }
}
