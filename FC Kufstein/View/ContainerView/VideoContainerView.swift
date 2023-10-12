//
//  VideoContainerView.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 12.10.23.
//

import UIKit

protocol VideoContainerViewDelegate: AnyObject {
    func didTapVideoButton(_ view: VideoContainerView)
}

class VideoContainerView: UIView {
    
    // MARK: - Properties
    weak var delegate: VideoContainerViewDelegate?
    
    // MARK: - Components
    private let titleLabel = UILabel.createCustomLabel(
        text: "FC Kufstein TV",
        textColor: .label,
        fontSize: 18,
        fontWeight: .black
    )
    
    private let allVideoButton = CustomButton(
        title: "Video",
        hasBackground: false,
        fontSize: .med
    )
    
    private let videoView = VideoView()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension VideoContainerView {
    private func setupUI() {
        backgroundColor = .systemBackground
        setupTitleLabel()
        setupAllNewsButton()
        setupVideoView()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupAllNewsButton() {
        addSubview(allVideoButton)
        allVideoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allVideoButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            allVideoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            allVideoButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        allVideoButton.addTarget(self, action: #selector(didTapAllVideoButton), for: .touchUpInside)
    }
    
    private func setupVideoView() {
        addSubview(videoView)
        videoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            videoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            videoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            videoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Action
extension VideoContainerView {
    @objc private func didTapAllVideoButton() {
        delegate?.didTapVideoButton(self)
    }
}
