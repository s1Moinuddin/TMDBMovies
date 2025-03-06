//
//  MoviesTableViewCell.swift
//  TMDBMovies
//
//  Created by S.M.Moinuddin on 6/3/25.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MoviesTableViewCell"
    static let reuseIdentifierPopular = "PopularMoviesTableViewCell"
    
    private var collectionView: UICollectionView!
    var movies: [Movie] = []
    var reuseIdentifierForCollectionView: String = ""

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        //oherwise tableview cell not getting actual collectionViewCell height
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 220)
        contentViewHeightConstraint.priority = UILayoutPriority(999)
        contentViewHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.reuseIdentifier)
    }
    
    func configure(with movies: [Movie], reuseIdentifier: String) {
        self.reuseIdentifierForCollectionView = reuseIdentifier
        self.movies = movies
        collectionView.reloadData()
    }
}

extension MoviesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.reuseIdentifier, for: indexPath) as! PosterCollectionViewCell
        let movie = movies[indexPath.item]
        let imgURL = Helper.getImageURL(path: movie.imagePath)
        cell.imageView.kf.setImage(with: imgURL, placeholder: UIImage(named: "placeholder"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
