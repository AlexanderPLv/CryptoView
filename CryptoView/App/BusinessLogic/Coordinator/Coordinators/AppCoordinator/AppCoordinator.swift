//
//  AppCoordinator.swift
//  RoxieTest
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow?
    fileprivate let factory: CoordinatorFactoryProtocol
    fileprivate let router: Routable
    
    init(
        router: Routable,
        factory: CoordinatorFactoryProtocol,
        window: UIWindow?
    ) {
        self.router = router
        self.factory = factory
        self.window = window
        super.init()
        windowSettings()
    }
    
    class func build(
        router: Router,
        window: UIWindow?
    ) -> AppCoordinator {
        let factory = CoordinatorFactory()
        let appCoordinator = AppCoordinator(
            router: router,
            factory: factory,
            window: window
        )
        return appCoordinator
    }
    
    private func windowSettings() {
        window?.backgroundColor = Color.Common.background
    }
}

extension AppCoordinator: Coordinator {
    func start() {
        performOnboardingFlow()
        window?.makeKeyAndVisible()
    }
    
    private func performOnboardingFlow() {
        let coordinator = factory.makeOnboardingCoordinator(
            with: router
        )
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard
                let `self` = self,
                let `coordinator` = coordinator
            else { return }
            self.removeDependency(coordinator)
            self.performMainFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func performMainFlow() {
        guard let window = window else { return }
        let coordinator = factory.makeTabBarCoordinator(window: window, coordinatorFactory: factory)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.start()
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
