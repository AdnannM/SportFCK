//
//  SponsorsCollectionViewCell.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 18.10.23.
//

import UIKit

struct SponsorsModelData {
    let image: UIImage
    let url: URL?
}

struct SponsorsData {
    static let allSponsors: [SponsorsModelData] = [
        SponsorsModelData(image: UIImage(named: "alpquell-logo")!, url: URL(string: "https://www.alpquell.com/")),
        SponsorsModelData(image: UIImage(named: "FC Kufstein")!, url: URL(string: "https://www.kellys.at/")),
        SponsorsModelData(image: UIImage(named: "stadt-kufstein")!, url: URL(string: "https://www.kufstein.gv.at/")),
        SponsorsModelData(image: UIImage(named: "Interspar")!, url: URL(string: "https://www.interspar.at/")),
        SponsorsModelData(image: UIImage(named: "kufnet")!, url: URL(string: "https://www.kufnet.at/")),
        SponsorsModelData(image: UIImage(named: "kufstein-galerie")!, url: URL(string: "https://www.kufstein-galerien.at/home/?no_cache=1")),
        SponsorsModelData(image: UIImage(named: "LOsteria1")!, url: URL(string: "https://losteria.net/at/")),
        SponsorsModelData(image: UIImage(named: "moccador")!, url: URL(string: "https://www.moccador.at/de/partner-199/praesentation/aktuell")),
        SponsorsModelData(image: UIImage(named: "rztrsdfdsdElement-1")!, url: URL(string: "https://www.ricado-networks.com/")),
    ]
}

class SponsorsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "SponsorsCollectionViewCell"
    
    private let sponsorsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.2
        imageView.layer.borderColor = UIColor.systemGray5.cgColor
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    // MARK: - Layout
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
private extension SponsorsCollectionViewCell {
    private func setupUI() {
        backgroundColor = .systemGray6.withAlphaComponent(0.7)
        layer.cornerRadius = 8
        
        setupSponsorsImageView()
    }
    
    private func setupSponsorsImageView() {
        addSubview(sponsorsImageView)
        sponsorsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sponsorsImageView.topAnchor.constraint(equalTo: topAnchor),
            sponsorsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sponsorsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sponsorsImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - ConfigureCell
extension SponsorsCollectionViewCell {
    func configureCell(withModel model: SponsorsModelData) {
        sponsorsImageView.image = model.image
    }
}
