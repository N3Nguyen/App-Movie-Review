//
//  nowPlayingCollectionViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 15/11/2023.
//

import UIKit

class NowPlayingMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak private var homeView: UIView!
    @IBOutlet weak private var nameMovieLabel: UILabel!
    @IBOutlet weak private var genreMovieLabel: UILabel!
    @IBOutlet weak private var pointLabel: UILabel!
    @IBOutlet weak private var bookNowButton: UIButton!
    private var isAddGradientLayer = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }

    func setUpCollectionView() {
        bookNowButton.layer.cornerRadius = 15
        
        homeView.layer.cornerRadius = 16
        homeView.layer.borderWidth = 1
        homeView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
    }
    
    func bindDataNowPlaying(data: MovieEntity, indexCell: Int){
        nameMovieLabel.text = data.title
        
        let pointAverage = Double(data.voteAverage!)
        let roundedNumber = (pointAverage * 100).rounded() / 100
        pointLabel.text = "\(roundedNumber)"
        
        let linkUrlImage = "https://image.tmdb.org/t/p/w500/" + (data.backdropPath ?? "alo")
        setImageFromStringrURL(stringUrl: linkUrlImage)
        setupCategoryLabel(data: data)
    }
    
    func setImageFromStringrURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            activityIndicator.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
            self.homeView.addSubview(activityIndicator)
            contentMode = .scaleToFill

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Error handling...
                guard let imageData = data else { return }

                DispatchQueue.main.async {
                    self.backgroundImageView.image = UIImage(data: imageData)
                    self.addBlackOverlay(to: self.backgroundImageView)
                    activityIndicator.stopAnimating()
                }
            }.resume()
        }
    }
    
    func setupCategoryLabel(data: MovieEntity) {
        if data.genreIDS?.count ?? 0 > 3 {
            let dataGenres = data.genreIDS?.prefix(3)
            let namesArray = dataGenres?.compactMap { id -> String? in
                if let genre = CategoryGenres.shared.listGenres.first(where: { $0.id == id }) {
                    return genre.name
                }
                return nil
            }
            genreMovieLabel.text = namesArray?.joined(separator: ", ")
        } else {
            let namesArray = data.genreIDS?.compactMap { id -> String? in
                if let genre = CategoryGenres.shared.listGenres.first(where: { $0.id == id }) {
                    return genre.name
                }
                return nil
            }
            genreMovieLabel.text = namesArray?.joined(separator: ", ")
        }
    }
    
    func addBlackOverlay(to imageView: UIImageView) {
        let bottomGradientLayer = CAGradientLayer()
        bottomGradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        bottomGradientLayer.locations = [0.0, 1.0]
        bottomGradientLayer.frame = backgroundImageView.bounds
        
        if !isAddGradientLayer {
            backgroundImageView.layer.addSublayer(bottomGradientLayer)
            isAddGradientLayer = true
        }
    }
    
    @IBAction func didTapBookNow(_ sender: UIButton) {
    }
}
