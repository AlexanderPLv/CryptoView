//
//  OnboardingCoordinator.swift
//  RoxieTest
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import Foundation

protocol OnBoardingCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
 
final class OnBoardingCoordinator: BaseCoordinator, OnBoardingCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let factory: OnboardingBuilderProtocol & AlertBuilderProtocol
    fileprivate let router: Routable
    
    init(router: Routable, factory: OnboardingBuilderProtocol & AlertBuilderProtocol) {
        self.router = router
        self.factory = factory
    }
}
 
extension OnBoardingCoordinator: Coordinator {
    func start() {
        performFlow()
    }
}

private extension OnBoardingCoordinator {
    func performFlow() {
        let view = factory.buildOnboardingScreen()
        view.close = finishFlow
        view.showErrorWithMessage = { [weak self] message in
            self?.showError(with: message)
        }
        router.setRootModule(view, hideBar: true)
    }
    
    func showError(with message: String) {
        let alert = factory.buildErrorAlert(message: message, completionHandler: finishFlow)
        router.present(alert)
    }
}
