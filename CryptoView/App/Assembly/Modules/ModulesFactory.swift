//
//  ModulesFactory.swift
//  RoxieTest
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import UIKit
import WebKit

protocol OnboardingBuilderProtocol {
    func buildOnboardingScreen() -> OnboardingScreen
}

protocol TradeBuilderProtocol {
    func buildTradeScreen() -> TradeScreen
    func buildSelectPairScreen(selectedPair: CurrencyPair,delegate: PairSelectionDelegate) -> SelectPairScreen
}

protocol TopBuilderProtocol {
    func buildTopScreen() -> TopScreen
}

final class ModulesFactory {
    static let shared = ModulesFactory()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .clear
        webView.isOpaque = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        webView.underPageBackgroundColor = Color.Common.background
        return webView
    }()
    
    private init() {}
    
}

extension ModulesFactory: OnboardingBuilderProtocol {
    func buildOnboardingScreen() -> OnboardingScreen {
        let controller = OnboardingScreen(webView: webView)
        return controller
    }
}

extension ModulesFactory: TradeBuilderProtocol {
    func buildTradeScreen() -> TradeScreen {
        let viewModel = TradeScreenViewModel()
        let screen = TradeScreen(viewModel: viewModel, webView: webView)
        screen.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "unselectTrade"),
            selectedImage: UIImage(named: "selectedTrade")
        )
        return screen
    }
    
    func buildSelectPairScreen(selectedPair: CurrencyPair,delegate: PairSelectionDelegate) -> SelectPairScreen {
        let screen = SelectPairScreen(selectedPair: selectedPair, delegate: delegate)
        return screen
    }
}

extension ModulesFactory: TopBuilderProtocol {
    func buildTopScreen() -> TopScreen {
        let screen = TopScreen()
        screen.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "unselectTop"),
            selectedImage: UIImage(named: "selectedTop")
        )
        return screen
    }
}
