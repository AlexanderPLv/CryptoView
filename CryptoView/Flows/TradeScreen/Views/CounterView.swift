//
//  CounterView.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import Combine
import UIKit
import SnapKit

enum Counter {
    case add
    case subtract
}

final class CounterView: UIView {
    
    var tapped = PassthroughSubject<Counter, Never>()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.medium(ofSize: 12.0)
        view.textColor = Color.Common.lightGrayText
        view.numberOfLines = 1
        view.textAlignment = .center
        return view
    }()
    
    private lazy var plusButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "counterPlus"), for: .normal)
        view.addTarget(self, action: #selector(handleTapPlusButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var minusButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "counterMinus"), for: .normal)
        view.addTarget(self, action: #selector(handleTapMinusButton), for: .touchUpInside)
        return view
    }()
    
    let textField: UITextField = {
        let view = UITextField()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 16.0)
        view.keyboardType = .numberPad
        view.keyboardAppearance = .dark
        view.textAlignment = .center
        return view
    }()
    
    init(
        title: String
    ) {
        self.titleLabel.text = title
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let minusButtonFrame = minusButton.frame.insetBy(dx: -20, dy: -20)
        if minusButtonFrame.contains(point) {
            return minusButton
        }
        let plusButtonFrame = plusButton.frame.insetBy(dx: -20, dy: -20)
        if plusButtonFrame.contains(point) {
            return plusButton
        }
        return super.hitTest(point, with: event)
    }
}

private extension CounterView {
    
    @objc func handleTapPlusButton() {
        tapped.send(.add)
    }
    
    @objc func handleTapMinusButton() {
        tapped.send(.subtract)
    }
    
    func setupView() {
        backgroundColor = Color.Common.darkGray
        layer.borderColor = Color.Common.lightGreen.cgColor
        layer.cornerRadius = 12.0
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5.0)
            make.centerX.equalToSuperview()
        }
        addSubview(minusButton)
        minusButton.snp.makeConstraints { make in
            make.width.height.equalTo(15.0)
            make.leading.equalToSuperview().inset(15.0)
            make.bottom.equalToSuperview().inset(10.0)
        }
        addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.width.height.equalTo(15.0)
            make.trailing.equalToSuperview().inset(15.0)
            make.centerY.equalTo(minusButton.snp.centerY)
        }
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(7.0)
            make.leading.equalTo(minusButton.snp.trailing).offset(10.0)
            make.trailing.equalTo(plusButton.snp.leading).offset(-10.0)
            make.bottom.equalToSuperview().inset(8.0)
        }
    }
    
}
