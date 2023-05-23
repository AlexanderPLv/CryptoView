//
//  MainTabBarViewController.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 20.05.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTabBarAppearance()
    }
}

private extension MainTabBarViewController {
    
    func setupTabBarAppearance() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = Color.TabBar.background
        setTabBarHeight(62.0)
        tabBar.layer.borderColor = Color.TabBar.border.cgColor
        tabBar.layer.borderWidth = 0.5
    }
    
    private func setTabBarHeight(_ height: CGFloat) {
        let bottomInset = view.safeAreaInsets.bottom
        let tabBarHeight = bottomInset + height
        var newTabBarFrame = tabBar.frame
        newTabBarFrame.size.height = tabBarHeight
        newTabBarFrame.origin.y = self.view.frame.size.height - tabBarHeight
        tabBar.frame = newTabBarFrame
    }
}
