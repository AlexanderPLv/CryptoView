//
//  TabBarCoordinator.swift
//  Wasabi
//
//  Created by Alexander Pelevinov on 06.12.2022.
//  Copyright © 2022 Fokus IT. All rights reserved.
//

import UIKit

protocol TabBarCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

protocol TabBarItem {
    var flowNavigationController: UIViewController { get }
}
 
final class TabBarCoordinator: BaseCoordinator, TabBarCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    private var window: UIWindow
    private let modulesFactory: TabBarBuilderProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let router: TabBarRouter
    
    init(
        window: UIWindow,
        router: TabBarRouter,
        factory: TabBarBuilderProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol
    ) {
        self.window = window
        self.router = router
        self.modulesFactory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init()
    }
}

extension TabBarCoordinator: Coordinator {
    func start() {
        performFlow()
    }
}

private extension TabBarCoordinator {
    func performFlow() {
        guard let module = router.toPresent else { return }
        
        let tradeCoordinator = coordinatorFactory.makeTradeCoordinator()
        addDependency(tradeCoordinator)
        tradeCoordinator.start()
        let topCoordinator = coordinatorFactory.makeTopCoordinator()
        addDependency(topCoordinator)
        topCoordinator.start()
        
        module.viewControllers = [
            tradeCoordinator.flowNavigationController,
            topCoordinator.flowNavigationController
        ]
        
        router.setTabBarAsRoot(to: window)
    }
}
