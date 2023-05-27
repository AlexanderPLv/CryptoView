//
//  TradeScreen.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 20.05.2023.
//

import UIKit
import Combine
import SnapKit
import WebKit

final class TradeScreen: KeyboardViewController {
    
    var onSelectPairScreen: ((CurrencyPair) -> ())?
    var showSuccessAlert: CompletionBlock?
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
    private let webView: WKWebView
    private let sellButton = CustomButton(title: "Sell", color: Color.Common.red)
    private let buyButton = CustomButton(title: "Buy", color: Color.Common.lightGreen)
    private let currencyPairButton: CustomButton
    private let timerView: CounterView
    private let investmentView: CounterView
    private var bottomSheetConstraint: Constraint?
    
    private let viewModel: TradeScreenViewModel
    private let investmentViewViewModel: InvestmentCounterViewModel
    private let timerViewViewModel: TimerCounterViewModel
    
    init(
        viewModel: TradeScreenViewModel,
        webView: WKWebView
    ) {
        self.viewModel = viewModel
        self.timerViewViewModel = TimerCounterViewModel(title: "Timer")
        self.timerView = CounterView(
            viewModel: timerViewViewModel
        )
        self.investmentViewViewModel = InvestmentCounterViewModel(title: "Investment", step: 100)
        self.investmentView = CounterView(
            viewModel: investmentViewViewModel
        )
        self.balanceView = BalanceView()
        self.currencyPairButton = CustomButton(
            title: viewModel.currentCurrencyPair().rawValue,
            titleFont: .boldSystemFont(ofSize: 16.0),
            titleAligment: .center,
            color: Color.Common.darkGray,
            hideArrow: false)
        self.webView = webView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
        viewModel.setInitialValues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.scrollView.pinchGestureRecognizer?.isEnabled = false
        webView.scrollView.panGestureRecognizer.isEnabled = false
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
        setupBottomSheetlayout()
        setupWebViewLayout()
    }
    
    func setupBottomSheetlayout() {
        let buttonStack = UIStackView(arrangedSubviews: [sellButton, buyButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 10.0
        
        let counterStack = UIStackView(arrangedSubviews: [timerView, investmentView])
        counterStack.axis = .horizontal
        counterStack.distribution = .fillEqually
        counterStack.spacing = 10.0
        
        let bottomSheetBackgroundView = UIView()
        bottomSheetBackgroundView.backgroundColor = Color.Common.background
        
        let bottomSheetStack = UIStackView(arrangedSubviews: [
            currencyPairButton, counterStack, buttonStack
        ])
        bottomSheetStack.axis = .vertical
        bottomSheetStack.spacing = 10.0
        
        bottomSheetBackgroundView.addSubview(bottomSheetStack)
        bottomSheetStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15.0)
            make.leading.trailing.equalToSuperview().inset(30.0)
            make.bottom.equalToSuperview().inset(12.0)
        }
        
        view.addSubview(bottomSheetBackgroundView)
        bottomSheetBackgroundView.snp.makeConstraints { make in
            bottomSheetConstraint = make.bottom.equalToSuperview().constraint
            make.leading.trailing.equalToSuperview()
        }
        bottomSheetConstraint?.activate()
    }
    
    func setupWebViewLayout() {
        view.insertSubview(webView, at: 1)
        let guide = view.safeAreaLayoutGuide
        var bottomPadding: CGFloat = 0
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            bottomPadding = window.safeAreaInsets.bottom
        }
        let height = guide.layoutFrame.height - (455 + bottomPadding)
        webView.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.top.equalTo(balanceView.snp.bottom).offset(25.0)
            make.leading.trailing.equalToSuperview().inset(10.0)
        }
        webView.layer.borderColor = Color.Common.background.cgColor
        webView.layer.borderWidth = 5.0
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = Color.Common.background
        webView.addSubview(bottomBorder)
        bottomBorder.snp.makeConstraints { make in
            make.height.equalTo(20.0)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind() {
        sellButton.tapped
            .sink { [weak self] _ in
                self?.viewModel.sell()
            }.store(in: &bag)
        buyButton.tapped
            .sink { [weak self] _ in
                self?.viewModel.sell()
            }.store(in: &bag)
        currencyPairButton.tapped
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.onSelectPairScreen?(self.viewModel.currentCurrencyPair())
            }.store(in: &bag)
        viewModel.balance
            .subscribe(balanceView.currentBalance)
            .store(in: &bag)
        viewModel.success
            .sink { [weak self] _ in
                self?.showSuccessAlert?()
            }.store(in: &bag)
        viewModel.balance
            .subscribe(investmentViewViewModel.balance)
            .store(in: &bag)
        viewModel.updateTimer
            .subscribe(timerViewViewModel.inputTimerValue)
            .store(in: &bag)
        viewModel.updateInvestment
            .subscribe(investmentViewViewModel.inputInvestmentValue)
            .store(in: &bag)
        investmentViewViewModel.outputInvestmentValue
            .sink { [weak self] value in
                self?.viewModel.setInvestmentAmount(value)
            }.store(in: &bag)
    }
}

extension TradeScreen: PairSelectionDelegate {
    func didSelectPair(_ pair: CurrencyPair) {
        DispatchQueue.main.async {
            self.webView.loadHTMLString(HTML.string(with: pair.requestSymbol), baseURL: nil)
        }
    }
}
