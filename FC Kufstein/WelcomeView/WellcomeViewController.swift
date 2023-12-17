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
    
//    // MARK: - Component
    private lazy var titleLabel = UILabel.createCustomLabel(
        text: "Willkommen beim FC Kufstein",
        textColor: .label,
        fontSize: 32,
        fontWeight: .medium
    )
    
    private lazy var containerView = UIView.createView(withColor: .systemGray6)
    
    private lazy var continueButton = UIButton()
    
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
        
        setupTitleLabel()
        setupContainerView()
        setupExploreAppButton()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
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
            continueButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 50),
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
