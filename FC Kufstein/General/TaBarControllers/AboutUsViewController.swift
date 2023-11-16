//
//  AboutUsViewController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 16.11.23.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    // MARK: - Properties
    private var models = [AboutUsSection]()
    
    // MARK: - Components
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(AboutUsTableViewCell.self, forCellReuseIdentifier: AboutUsTableViewCell.cellID)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        congigure()
    }
}

// MARK: - SetupUI
private extension AboutUsViewController {
    private func setupUI() {
        title = "About Us"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemGray6
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AboutUsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutUsTableViewCell.cellID, for: indexPath) as? AboutUsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = models[section]
        return model.tittle
    }
}

extension AboutUsViewController {
    func congigure() {
        if let originalImage = UIImage(named: "facebook") {
            let resizedImage3 = originalImage.resized(to: CGSize(width: 100, height: 100))
            
            models.append(AboutUsSection(tittle: "General", options: [
                AboutUsOptions(title: "Wifi", icon: resizedImage3, iconBackground: .systemGray4, handler: {
                    print("First")
                }),
                AboutUsOptions(title: "Wifi", icon: resizedImage3, iconBackground: .systemGray5, handler: {
                    print("Second")
                }),
                AboutUsOptions(title: "Wifi", icon: resizedImage3, iconBackground: .systemGray2, handler: {
                    print("Third")
                }),
                AboutUsOptions(title: "Wifi", icon: resizedImage3, iconBackground: .systemOrange, handler: {
                    print("Fourth")
                }),
            ]))
        }
        
        models.append(AboutUsSection(tittle: "Media", options: [
            AboutUsOptions(title: "Wifi", icon: UIImage(systemName: "house"), iconBackground: .systemBlue, handler: {
                
            }),
            AboutUsOptions(title: "Wifi", icon: UIImage(systemName: "house"), iconBackground: .systemRed, handler: {
                
            }),
            AboutUsOptions(title: "Wifi", icon: UIImage(systemName: "house"), iconBackground: .systemYellow, handler: {
                
            }),
            AboutUsOptions(title: "Wifi", icon: UIImage(systemName: "house"), iconBackground: .systemOrange, handler: {
                
            }),
        ]))
        
        models.append(AboutUsSection(tittle: "Kontact", options: [
            AboutUsOptions(title: "Wifi", icon: UIImage(systemName: "app-store-circle-fill"), iconBackground: .systemBlue, handler: {
                
            }),
            AboutUsOptions(title: "Wifi", icon: UIImage(systemName: "house"), iconBackground: .systemRed, handler: {
                
            }),
            AboutUsOptions(title: "Wifi", icon: UIImage(systemName: "house"), iconBackground: .systemYellow, handler: {
                
            }),
            AboutUsOptions(title: "Wifi", icon: UIImage(systemName: "house"), iconBackground: .systemOrange, handler: {
                
            }),
        ]))
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
