//
//  PosterCollectionViewCell.swift
//  TMDBMovies
//
//  Created by S.M.Moinuddin on 6/3/25.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PosterCollectionViewCell"
    static let reuseIdentifierPopular = "PopularPosterCollectionViewCell"
    
    let imageView: UIImageView = {
        let imgV = UIImageView(frame: CGRect.zero)
        imgV.contentMode = .scaleAspectFill
        imgV.layer.cornerRadius = 10
        imgV.layer.masksToBounds = true
        imgV.translatesAutoresizingMaskIntoConstraints = false
        return imgV
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
