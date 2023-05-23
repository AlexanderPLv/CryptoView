//
//  TopCoordinator.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 20.05.2023.
//

import UIKit

protocol TopCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

final class TopCoordinator: BaseCoordinator, TopCoordinatorOutput, TabBarItem {
    
    var flowNavigationController: UIViewController {
        router.toPresent!
    }
    
    var finishFlow: CompletionBlock?
    
    private let router: Routable
    private let factory: TopBuilderProtocol

    init(
        router: Routable,
        factory: TopBuilderProtocol
    ) {
        self.router = router
        self.factory = factory
        super.init()
    }
}

extension TopCoordinator: Coordinator {
    func start() {
        performFlow()
    }
}

private extension TopCoordinator {

    func performFlow() {
        let view = factory.buildTopScreen()
        
        router.setRootModule(view, hideBar: true)
    }
    
    func dismiss() {
        router.dismissModule()
    }
}
