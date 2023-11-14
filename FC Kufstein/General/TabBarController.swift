//
//  TabBarController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
}

// MARK: - Helpers
private extension TabBarController {
    private func configureTabs() {
        let home = HomeController()
        let match = MatchController()
        let table = TableViewController()
        
        home.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), selectedImage: nil)
        match.tabBarItem = UITabBarItem(title: "Match", image: UIImage(systemName: "soccerball.inverse"), selectedImage: nil)
        table.tabBarItem = UITabBarItem(title: "Table", image: UIImage(systemName: "list.bullet"), selectedImage: nil)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray6
        
        let homeNav = UINavigationController(rootViewController: home)
        let matchNav = UINavigationController(rootViewController: match)
        let tableNav = UINavigationController(rootViewController: table)
        
        setViewControllers([homeNav, matchNav, tableNav], animated: true)
        
        // Separate instances of UITabBarItem for customization
        home.navigationItem.title = "FC Kufstein News"
        match.navigationItem.title = "Letzte Spiele"
        table.navigationItem.title = "Tabelen"
    }
}











