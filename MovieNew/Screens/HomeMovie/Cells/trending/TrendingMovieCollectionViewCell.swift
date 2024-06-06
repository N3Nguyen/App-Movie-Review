//
//  CollectionViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 12/11/2023.
//

import UIKit

class TrendingMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var backgroundMovieTredingImageView: UIImageView!
    @IBOutlet weak var nameMovieTrendingLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    
    @IBOutlet weak var releaseDateMovieLabel: UILabel!
    @IBOutlet weak var pointReviewMovieLabel: UILabel!
    @IBOutlet weak var describeMovieLabel: UILabel!
    
    private var isAddGradientLayer = false
    private let getData: CategoryMovie? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 20
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
    }
    
    func setImageFromStringrURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            activityIndicator.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
            self.cellView.addSubview(activityIndicator)
            contentMode = .scaleToFill

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Error handling...
                guard let imageData = data else { return }

                DispatchQueue.main.async {
                    self.backgroundMovieTredingImageView.image = UIImage(data: imageData)
                    self.addBlackOverlay(to: self.backgroundMovieTredingImageView)
                    activityIndicator.stopAnimating()
                }
            }.resume()
        }
    }
    
    func getDataMovieTreding(data: MovieEntity, indexCell: Int,genresMovie: ListGenresResponseEntity ) {
        nameMovieTrendingLabel.text = data.title
        
        setUpCategoryLabel(data: data, genresMovies: genresMovie)
        let pointAverage = Double(data.voteAverage!)
        let roundedNumber = (pointAverage * 100).rounded() / 100
        pointReviewMovieLabel.text = "\(roundedNumber)"
        
        describeMovieLabel.text = data.overview
        
        let yearRelease = data.releaseDate?.prefix(4)
        releaseDateMovieLabel.text = yearRelease?.description
        let linkUrlImage = "https://image.tmdb.org/t/p/w500/" + (data.backdropPath ?? "alo")
        setImageFromStringrURL(stringUrl: linkUrlImage)
    }
    
    func setUpCategoryLabel(data: MovieEntity, genresMovies: ListGenresResponseEntity){
        let namesArray = data.genreIDS?.compactMap { id -> String? in
            if let genre = genresMovies.genres.first(where: { $0.id == id }) {
                return genre.name
            }
            return nil
        }
        movieGenreLabel.text = namesArray?.joined(separator: ", ")
    }
    
    func addBlackOverlay(to imageView: UIImageView) {
        
        let topGradientLayer = CAGradientLayer()
        topGradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        topGradientLayer.locations = [0.0, 0.3]
        topGradientLayer.frame = backgroundMovieTredingImageView.bounds
        
        let bottomGradientLayer = CAGradientLayer()
        bottomGradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        bottomGradientLayer.locations = [0.0, 1.0]
        bottomGradientLayer.frame = backgroundMovieTredingImageView.bounds
        
        if !isAddGradientLayer {
            backgroundMovieTredingImageView.layer.addSublayer(topGradientLayer)
            backgroundMovieTredingImageView.layer.addSublayer(bottomGradientLayer)
            isAddGradientLayer = true
        }
    }
}
