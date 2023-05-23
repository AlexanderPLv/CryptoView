//
//  ModulesFactory.swift
//  RoxieTest
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import UIKit

protocol OnboardingBuilderProtocol {
    func buildOnboardingScreen() -> OnboardingScreen
}

protocol TradeBuilderProtocol {
    func buildTradeScreen() -> TradeScreen
    func buildSelectPairScreen() -> SelectPairScreen
}

protocol TopBuilderProtocol {
    func buildTopScreen() -> TopScreen
}

final class ModulesFactory {
    
    init() {
        
    }
    
    class func build() -> ModulesFactory {
        let factory = ModulesFactory()
        return factory
    }
}

extension ModulesFactory: OnboardingBuilderProtocol {
    func buildOnboardingScreen() -> OnboardingScreen {
        let controller = OnboardingScreen()
        return controller
    }
}

extension ModulesFactory: TradeBuilderProtocol {
    func buildTradeScreen() -> TradeScreen {
        let timerFormatter = TimerFormatter()
        let investmentFormatter = TextFieldInvestmentFormatter()
        let timerObserver = TextFieldObserver(formatter: timerFormatter)
        let investmentObserver = TextFieldObserver(formatter: investmentFormatter)
        let viewModel = TradeScreenViewModel(timerObserver: timerObserver, investmentObserver: investmentObserver)
        let screen = TradeScreen(viewModel: viewModel, timerObserver: timerObserver, investmentObserver: investmentObserver)
        screen.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "unselectTrade"),
            selectedImage: UIImage(named: "selectedTrade")
        )
        return screen
    }
    
    func buildSelectPairScreen() -> SelectPairScreen {
        let screen = SelectPairScreen()
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
