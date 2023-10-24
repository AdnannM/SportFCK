//
//  VideoCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 16.10.23.
//

import UIKit
import WebKit

protocol VideoCollectionViewCellDelegate: AnyObject {
    func videoCellImageTapped()
}

class VideoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "VideoCollectionViewCell"
    var videoURL: URL?
    
    weak var delegate: VideoCollectionViewCellDelegate?
    
    // MARK: - Comonents
    private let videoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        let image = UIImage(named: "videoImage")
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40) // Adjust the pointSize as needed
        button.setImage(UIImage(systemName: "play.rectangle", withConfiguration: largeConfig), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let videoTitle = UILabel.createCustomLabel(
        text: "Kufstein U9 - 2023 10",
        textColor: .white,
        fontSize: 18,
        fontWeight: .semibold
    )
    
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
private extension VideoCollectionViewCell {
    private func setupUI() {
        backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        
        setupVideoImage()
        setupPlayButton()
        setupVideoTitle()
    }
    
    private func setupVideoImage() {
        contentView.addSubview(videoImage)
        videoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            videoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        videoImage.addGestureRecognizer(tapGesture)
    }
    
    private func setupPlayButton() {
        videoImage.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: videoImage.leadingAnchor, constant: 8),
            playButton.bottomAnchor.constraint(equalTo: videoImage.bottomAnchor, constant: -8),
        ])
    }
    
    private func setupVideoTitle() {
        videoImage.addSubview(videoTitle)
        videoTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            videoTitle.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            videoTitle.trailingAnchor.constraint(equalTo: videoImage.trailingAnchor, constant: -8),
            videoTitle.bottomAnchor.constraint(equalTo: videoImage.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Action
extension VideoCollectionViewCell {
    @objc func imageTapped() {
        delegate?.videoCellImageTapped()
    }
}
