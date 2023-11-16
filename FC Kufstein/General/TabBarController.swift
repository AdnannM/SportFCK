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
        
        home.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "soccerball.inverse"), selectedImage: nil)
        match.tabBarItem = UITabBarItem(title: "Match", image: UIImage(systemName: "sportscourt"), selectedImage: nil)
        table.tabBarItem = UITabBarItem(title: "Table", image: UIImage(systemName: "list.bullet"), selectedImage: nil)
        aboutUs.tabBarItem = UITabBarItem(title: "AboutUs", image: UIImage(systemName: "filemenu.and.selection"), selectedImage: nil)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray6
        
        let homeNav = UINavigationController(rootViewController: home)
        let matchNav = UINavigationController(rootViewController: match)
        let tableNav = UINavigationController(rootViewController: table)
        let aboutNav = UINavigationController(rootViewController: aboutUs)
        
        setViewControllers([homeNav, matchNav, tableNav, aboutNav], animated: true)
        
        // Separate instances of UITabBarItem for customization
        home.navigationItem.title = "FC Kufstein News"
        match.navigationItem.title = "Letzte Spiele"
        table.navigationItem.title = "Tabelen"
        aboutUs.navigationItem.title = "About Us"
    }
}











