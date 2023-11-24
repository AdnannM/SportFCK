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
        let aboutUs = AboutUsViewController()
        let nextGen = NextGenerationController()
        
        home.tabBarItem = UITabBarItem(title: "Aktuell", image: UIImage(systemName: "newspaper"), selectedImage: nil)
        match.tabBarItem = UITabBarItem(title: "Spiele", image: UIImage(systemName: "sportscourt"), selectedImage: nil)
        table.tabBarItem = UITabBarItem(title: "Tabelen", image: UIImage(systemName: "list.bullet"), selectedImage: nil)
        aboutUs.tabBarItem = UITabBarItem(title: "Über uns", image: UIImage(systemName: "info.circle.fill"), selectedImage: nil)
        nextGen.tabBarItem = UITabBarItem(title: "NextGen", image: UIImage(systemName: "person.2"), selectedImage: nil)

        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray6
        
        let homeNav = UINavigationController(rootViewController: home)
        let matchNav = UINavigationController(rootViewController: match)
        let tableNav = UINavigationController(rootViewController: table)
        let aboutNav = UINavigationController(rootViewController: aboutUs)
        let nextGenNav = UINavigationController(rootViewController: nextGen)
        
        setViewControllers([homeNav, matchNav, tableNav, nextGenNav, aboutNav], animated: true)
        
        // Separate instances of UITabBarItem for customization
        home.navigationItem.title = "FC Kufstein News"
        match.navigationItem.title = "Letzte Spiele"
        table.navigationItem.title = "Tabelen"
        aboutUs.navigationItem.title = "Über uns"
        nextGen.navigationItem.title = "Nächste Generation"
    }
}











