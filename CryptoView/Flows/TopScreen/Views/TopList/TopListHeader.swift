//
//  TopListHeader.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import UIKit
import SnapKit

class TopListHeader: UICollectionReusableView, ReusableView {
    
    private let indexLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.medium(ofSize: 14.0)
        view.textColor = Color.Common.lightGrayText
        view.numberOfLines = 1
        view.textAlignment = .left
        view.text = "№"
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    private let countryLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.medium(ofSize: 14.0)
        view.textColor = Color.Common.lightGrayText
        view.numberOfLines = 1
        view.textAlignment = .left
        view.text = "Country"
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.medium(ofSize: 14.0)
        view.textColor = Color.Common.lightGrayText
        view.numberOfLines = 1
        view.textAlignment = .center
        view.text = "Name"
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    private let depositLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.medium(ofSize: 14.0)
        view.textColor = Color.Common.lightGrayText
        view.numberOfLines = 1
        view.textAlignment = .right
        view.text = "Deposit"
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    private let profitLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.medium(ofSize: 14.0)
        view.textColor = Color.Common.lightGrayText
        view.numberOfLines = 1
        view.textAlignment = .right
        view.text = "Profit"
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TopListHeader {
    func setupView() {
        backgroundColor = Color.Common.listCellBackground
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let stack = UIStackView(arrangedSubviews: [
            indexLabel,
            HSpacer(5.0),
            countryLabel,
            HSpacer(20.0),
            nameLabel,
            HSpacer(14.0),
            depositLabel,
            HSpacer(20.0),
            profitLabel
        ])
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fillProportionally
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(9.0)
            make.trailing.equalToSuperview().inset(14.0)
        }
    }
}
