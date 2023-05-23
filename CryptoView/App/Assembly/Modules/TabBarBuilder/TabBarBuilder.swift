//
//  TabBarBuilder.swift
//  Wasabi
//
//  Created by Alexander Pelevinov on 07.12.2022.
//  Copyright © 2022 Fokus IT. All rights reserved.
//

import UIKit

protocol TabBarBuilderProtocol {
    func buildTabBarController() -> MainTabBarViewController
}

extension ModulesFactory: TabBarBuilderProtocol {
    func buildTabBarController() -> MainTabBarViewController {
        let controller = MainTabBarViewController()
        return controller
    }
}
