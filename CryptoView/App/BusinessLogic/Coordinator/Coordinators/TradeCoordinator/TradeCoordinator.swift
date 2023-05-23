//
//  TradeCoordinator.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 20.05.2023.
//

import UIKit

protocol TradeCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

final class TradeCoordinator: BaseCoordinator, TradeCoordinatorOutput, TabBarItem {
    
    var flowNavigationController: UIViewController {
        router.toPresent!
    }
    
    var finishFlow: CompletionBlock?
    
    private let router: Routable
    private let factory: TradeBuilderProtocol

    init(
        router: Routable,
        factory: TradeBuilderProtocol
    ) {
        self.router = router
        self.factory = factory
        super.init()
    }
}

extension TradeCoordinator: Coordinator {
    func start() {
        performFlow()
    }
}

private extension TradeCoordinator {

    func performFlow() {
        let view = factory.buildTradeScreen()
        view.onSelectPairScreen = runSelectPairScreen
        router.setRootModule(view, hideBar: true)
    }
    
    func runSelectPairScreen() {
        let view = factory.buildSelectPairScreen()
        view.close = router.popModule
        router.push(view)
    }
    
    func dismiss() {
        router.dismissModule()
    }
}
