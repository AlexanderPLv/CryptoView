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
    private let factory: TradeBuilderProtocol & AlertBuilderProtocol

    init(
        router: Routable,
        factory: TradeBuilderProtocol & AlertBuilderProtocol
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
        view.onSelectPairScreen = { [weak self, unowned view] selectedPair in
            self?.runSelectPairScreen(selectedPair: selectedPair, delegate: view)
        }
        view.showSuccessAlert = runSuccessAlert
        router.setRootModule(view, hideBar: true)
    }
    
    func runSelectPairScreen(selectedPair: CurrencyPair, delegate: PairSelectionDelegate) {
        let view = factory.buildSelectPairScreen(selectedPair: selectedPair, delegate: delegate)
        view.close = router.popModule
        router.push(view)
    }
    
    func runSuccessAlert() {
        let view = factory.buildSuccessAlert(completionHandler: dismiss)
        router.present(view)
    }
    
    func dismiss() {
        router.dismissModule()
    }
}
