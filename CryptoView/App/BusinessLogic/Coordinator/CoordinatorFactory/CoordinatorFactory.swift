//
//  CoordinatorFactory.swift
//  RoxieTest
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import UIKit

protocol CoordinatorFactoryProtocol {
    func makeTabBarCoordinator(window: UIWindow, coordinatorFactory: CoordinatorFactoryProtocol) -> Coordinator
    & TabBarCoordinatorOutput
    func makeTopCoordinator() -> Coordinator
    & TopCoordinatorOutput & TabBarItem
    func makeTradeCoordinator() -> Coordinator & TradeCoordinatorOutput & TabBarItem
    func makeOnboardingCoordinator(
        with router: Routable
    ) -> Coordinator & OnBoardingCoordinatorOutput
}

final class CoordinatorFactory {
    private lazy var modulesFactory = ModulesFactory.shared
}
 
extension CoordinatorFactory: CoordinatorFactoryProtocol {
    
    func makeOnboardingCoordinator(with router: Routable) -> Coordinator
    & OnBoardingCoordinatorOutput {
        return OnBoardingCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeTradeCoordinator() -> Coordinator
    & TradeCoordinatorOutput & TabBarItem {
        let navController = UINavigationController()
        let router = Router.build(with: navController)
        return TradeCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeTopCoordinator() -> Coordinator
    & TopCoordinatorOutput & TabBarItem {
        let navigationController = UINavigationController()
        let router = Router.build(with: navigationController)
        return TopCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeTabBarCoordinator(
        window: UIWindow,
        coordinatorFactory: CoordinatorFactoryProtocol
    ) -> Coordinator & TabBarCoordinatorOutput {
        let tabBar = modulesFactory.buildTabBarController()
        let router = TabBarRouter(rootController: tabBar)
        return TabBarCoordinator(
            window: window,
            router: router,
            factory: modulesFactory,
            coordinatorFactory: coordinatorFactory
        )
    }
    
}
