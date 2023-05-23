//
//  TradeScreen.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 20.05.2023.
//

import UIKit
import Combine
import SnapKit

final class TradeScreen: KeyboardViewController {
    
    var onSelectPairScreen: CompletionBlock?
    private var bag = [AnyCancellable]()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.bold(ofSize: 22.0)
        view.textColor = .white
        view.numberOfLines = 1
        view.text = "Trade"
        view.textAlignment = .center
        return view
    }()
    
    private let balanceView: BalanceView
    private let webView = UIView()
    private let sellButton = CustomButton(title: "Sell", color: Color.Common.buttonRed)
    private let buyButton = CustomButton(title: "Buy", color: Color.Common.lightGreen)
    private let currencyPairButton: CustomButton
    private let timerView: CounterView
    private let investmentView: CounterView
    
    private var bottomSheetConstraint: Constraint?
    
    private let viewModel: TradeScreenViewModel
    
    init(
        viewModel: TradeScreenViewModel,
        timerObserver: TextFieldObserver,
        investmentObserver: TextFieldObserver
    ) {
        self.viewModel = viewModel
        self.timerView = CounterView(title: "Timer")
        self.investmentView = CounterView(title: "Investment")
        self.balanceView = BalanceView(amount: viewModel.getBalance())
        self.currencyPairButton = CustomButton(
            title: viewModel.currentCurrencyPair(),
            titleFont: .boldSystemFont(ofSize: 16.0),
            titleAligment: .center,
            color: Color.Common.darkGray,
            hideArrow: false)
        timerObserver.addObservable(timerView.textField)
        investmentObserver.addObservable(investmentView.textField)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    override func keyboardWasShown(notification: Notification) {
        guard let info = notification.userInfo,
              let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size,
              let animationDuration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        UIView.animate(withDuration: animationDuration) {
            self.bottomSheetConstraint?.update(inset: keyboardSize.height - 62.0)
        }
    }
    
    override func keyboardWillBeHidden(notification: Notification) {
        guard let info = notification.userInfo,
              let animationDuration =
                (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: animationDuration) {
                self.bottomSheetConstraint?.update(inset: 12.0)
            }
        }
    }
}

private extension TradeScreen {
    
    func setupViews() {
        view.backgroundColor = Color.Common.background
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(64.0)
        }
        view.addSubview(balanceView)
        balanceView.snp.makeConstraints { make in
            make.height.equalTo(54.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(15.0)
            make.leading.trailing.equalToSuperview().inset(30.0)
        }
        
        let buttonStack = UIStackView(arrangedSubviews: [sellButton, buyButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 10.0
        
        let counterStack = UIStackView(arrangedSubviews: [timerView, investmentView])
        counterStack.axis = .horizontal
        counterStack.distribution = .fillEqually
        counterStack.spacing = 10.0
        
        let bottomSheetStack = UIStackView(arrangedSubviews: [currencyPairButton, counterStack, buttonStack])
        bottomSheetStack.axis = .vertical
        bottomSheetStack.spacing = 10.0
        view.addSubview(bottomSheetStack)
        bottomSheetStack.snp.makeConstraints { make in
            bottomSheetConstraint = make.bottom.equalToSuperview().inset(12.0).constraint
            make.leading.trailing.equalToSuperview().inset(30.0)
        }
        bottomSheetConstraint?.activate()
        
        view.addSubview(webView)
        webView.backgroundColor = .yellow
        webView.snp.makeConstraints { make in
            make.top.equalTo(balanceView.snp.bottom).offset(25.0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomSheetStack.snp.top).offset(-15.0)
        }
    }
    
    func bind() {
        sellButton.tapped
            .sink { [weak self] _ in
                print("tapped")
            }.store(in: &bag)
        buyButton.tapped
            .sink { [weak self] _ in
                print("tapped")
            }.store(in: &bag)
        currencyPairButton.tapped
            .sink { [weak self] _ in
                self?.onSelectPairScreen?()
            }.store(in: &bag)
        timerView.tapped
            .sink { [weak self] counter in
                self?.viewModel.changeTimerValue(counter)
            }.store(in: &bag)
        investmentView.tapped
            .sink { [weak self] counter in
                self?.viewModel.changeInvestmentAmount(counter)
            }.store(in: &bag)
    }
}
