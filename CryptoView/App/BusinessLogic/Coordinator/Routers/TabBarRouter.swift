//
//  TabBarRouter.swift
//  Wasabi
//
//  Created by Alexander Pelevinov on 06.12.2022.
//  Copyright © 2022 Fokus IT. All rights reserved.
//

import UIKit

enum TabBarPage: Int {
    case trade
    case top
}

final class TabBarRouter: NSObject {
    
    fileprivate var rootController: UITabBarController?

    init(rootController: UITabBarController) {
        self.rootController = rootController
    }

    var toPresent: UITabBarController? {
        return rootController
    }
    
    func select(_ page: TabBarPage) {
        guard let rootController else { return }
        guard rootController.selectedIndex != page.rawValue else { return }
        rootController.selectedIndex = page.rawValue
    }
    
    func setTabBarAsRoot(to window: UIWindow) {
        guard let rootController else { return }
        window.rootViewController = rootController
        
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3

        UIView.transition(
            with: window,
            duration: duration,
            options: options,
            animations: {}
        )
    }
    
    func currentPage() -> TabBarPage? {
        guard let rootController else { return nil }
        return TabBarPage(rawValue: rootController.selectedIndex)
    }
}
