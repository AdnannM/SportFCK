//
//  NewsCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 25.10.23.
//

import UIKit
import SDWebImage

class NewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "NewsCollectionViewCell"
    weak var delegate: NewsViewDelegate?
    var postURL: String = ""
    
    // MARK: - Components
    private let containerView = createView(withColor: .systemGray6)
    private let circleView = createView(withColor: .systemBackground)
    private let shareButtonView = createView(withColor: .systemGray6)
    
    private let shareImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square.and.arrow.up")
        imageView.tintColor = .label // You can set the tint color
        return imageView
    }()
    
    private let newsArticleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    private let newsArticleTitle = UILabel.createCustomLabel(
        text: "Der SK Ebbs siegte beim Qualifikationsturnier – unsere Mannschaft erreichte Platz 8",
        textColor: .label,
        fontSize: 18,
        fontWeight: .medium
    )
    
    private let newsDate = UILabel.createCustomLabel(
        text: "09.10.2023",
        textColor: .secondaryLabel,
        fontSize: 14,
        fontWeight: .regular
    )
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsArticleImage.image = nil
    }
}

// MARK: - SetupUI
private extension NewsCollectionViewCell {
    private func setupUI() {
        setupContainerView()
        setupCircleView()
        setupShareButtonView()
        setupShereImage()
        setupNewsArticleImage()
        setupNewsArticleTitle()
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
    }
    
    private func setupCircleView() {
        containerView.addSubview(circleView)
        
        NSLayoutConstraint.activate([
            circleView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            circleView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 5),
            circleView.widthAnchor.constraint(equalToConstant: 80), // Set the width and height to create a circle
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor),
        ])
        
        circleView.layer.cornerRadius = 40 // Set half of the width to make it circular
        circleView.clipsToBounds = true
    }
    
    private func setupShareButtonView() {
        circleView.addSubview(shareButtonView)
        
        NSLayoutConstraint.activate([
            shareButtonView.topAnchor.constraint(equalTo: circleView.topAnchor, constant: 10),
            shareButtonView.trailingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: -10),
            shareButtonView.leadingAnchor.constraint(equalTo: circleView.leadingAnchor, constant: 10),
            shareButtonView.bottomAnchor.constraint(equalTo: circleView.bottomAnchor, constant: -10),
            
            shareButtonView.widthAnchor.constraint(equalToConstant: 60), // Set the width and height to create a circle
            shareButtonView.heightAnchor.constraint(equalTo: shareButtonView.widthAnchor),
        ])
        
         shareButtonView.clipsToBounds = true
         shareButtonView.layer.cornerRadius = 30
    }
    
    private func setupShereImage() {
        shareButtonView.addSubview(shareImage)
        
        NSLayoutConstraint.activate([
            shareImage.centerXAnchor.constraint(equalTo: shareButtonView.centerXAnchor),
            shareImage.centerYAnchor.constraint(equalTo: shareButtonView.centerYAnchor),
            shareImage.heightAnchor.constraint(equalToConstant: 30),
            shareImage.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shareButtonTapped))
        shareButtonView.addGestureRecognizer(tapGesture)
        shareButtonView.isUserInteractionEnabled = true
    }
    
    private func setupNewsArticleImage() {
        containerView.addSubview(newsArticleImage)
        newsArticleImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsArticleImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            newsArticleImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            newsArticleImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            newsArticleImage.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        newsArticleImage.layer.cornerRadius = 20
        newsArticleImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupNewsArticleTitle() {
        // Create a UIStackView to hold newsArticleTitle and newsDate
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4 // Adjust the spacing as needed
        stackView.alignment = .leading

        // Add newsArticleTitle and newsDate to the stackView
        stackView.addArrangedSubview(newsArticleTitle)
        stackView.addArrangedSubview(newsDate)

        // Add the stackView to containerView
        containerView.addSubview(stackView)

        // Set maximum number of lines and add ellipsis for longer titles
        newsArticleTitle.lineBreakMode = .byTruncatingTail
        newsArticleTitle.numberOfLines = 2 // Adjust as needed based on your design

        NSLayoutConstraint.activate([
            // Constraints for the stackView
            stackView.topAnchor.constraint(equalTo: newsArticleImage.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -90),

        ])
        newsArticleTitle.textAlignment = .left
    }
}

// MARK: - Action
extension NewsCollectionViewCell {
    @objc private func shareButtonTapped() {
        if let collectionView = superview as? UICollectionView, let indexPath = collectionView.indexPath(for: self) {
            print("Tapped on indexPath.row: \(indexPath.row)") // Check if the correct indexPath is obtained
            delegate?.didTapShareButton(in: self, at: indexPath)
        }
    }
}

//MARK: - ConfigureCell
extension NewsCollectionViewCell {
    func configure(withData data: Post) {
        let placehoderImage = UIImage(named: "404")
        
        // Reset the image view to the placeholder image and show the loading indicator
        newsArticleImage.image = placehoderImage
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        newsArticleImage.addSubview(activityIndicator)
        activityIndicator.center = newsArticleImage.center
        activityIndicator.startAnimating()
        
        if let imageUrl = URL(string: data.jetpackFeaturedMediaURL) {
            // Use SDWebImage to load and set the image from the URL
            newsArticleImage.sd_setImage(
                with: imageUrl,
                placeholderImage: placehoderImage,
                options: [.progressiveLoad]
            ) { _, _, _, _ in
                // Hide the loading indicator when the image has finished loading
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        } else {
            // Handle articles without a valid image URL by setting the placeholder image directly
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
        
        postURL = data.link
        newsArticleTitle.text = data.title.rendered
        newsDate.text = data.date
    }
}


