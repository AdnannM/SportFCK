//
//  WellcomeViewController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 06.12.23.
//

import UIKit

class WellcomeViewController: UIViewController {
    
    private let wellcomeView = WellcomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        wellcomeView.delegate = self
    }
}

private extension WellcomeViewController {
    private func setupUI() {
        setupWellcomeView()
    }
    
    private func setupWellcomeView() {
        view.addSubview(wellcomeView)
        wellcomeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wellcomeView.topAnchor.constraint(equalTo: view.topAnchor),
            wellcomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wellcomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wellcomeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension WellcomeViewController: WellcomeViewDelegate {
    func didTapExploreButton() {
        let viewController = TabBarController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}








protocol WellcomeViewDelegate: AnyObject {
    func didTapExploreButton()
}

class WellcomeView: UIView {
    
    // MARK: - Properties
    weak var delegate: WellcomeViewDelegate?
    
    // MARK: - Component
    let continueButton = UIButton()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension WellcomeView {
    private func setupUI() {
        setupExploreAppButton()
    }
    
    private func setupExploreAppButton() {
        addSubview(continueButton)
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        continueButton.configuration = .tinted()
        continueButton.configuration?.title = "Weiter"
        continueButton.configuration?.image = UIImage(systemName: "figure.soccer")
        continueButton.configuration?.imagePadding = 9
        continueButton.configuration?.baseForegroundColor = .systemBlue
        continueButton.configuration?.baseBackgroundColor = .systemBlue
        continueButton.configuration?.cornerStyle = .capsule
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            continueButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        continueButton.layer.cornerRadius = 20
        
        continueButton.addTarget(self, action: #selector(didTapExploreButton), for: .touchUpInside)
    }
}

// MARK: - Action
extension WellcomeView {
    @objc private func didTapExploreButton() {
        delegate?.didTapExploreButton()
    }
}
