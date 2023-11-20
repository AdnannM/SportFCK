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
        
        home.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "soccerball.inverse"), selectedImage: nil)
        match.tabBarItem = UITabBarItem(title: "Match", image: UIImage(systemName: "sportscourt"), selectedImage: nil)
        table.tabBarItem = UITabBarItem(title: "Table", image: UIImage(systemName: "list.number"), selectedImage: nil)
        aboutUs.tabBarItem = UITabBarItem(title: "AboutUs", image: UIImage(systemName: "filemenu.and.selection"), selectedImage: nil)
        nextGen.tabBarItem = UITabBarItem(title: "NextGen", image: UIImage(systemName: "person.3.fill"), selectedImage: nil)
        
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
        aboutUs.navigationItem.title = "About Us"
        nextGen.navigationItem.title = "Next Generation"
    }
}











