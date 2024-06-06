//
//  discoverCollectionViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 15/11/2023.
//

import UIKit

class DiscoverMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var homeView: UIView!
    @IBOutlet weak var backgroundMoviesImageView: UIImageView!
    @IBOutlet weak var numberOfViewsView: UIView!
    @IBOutlet weak private var numberOfviewsLabel: UILabel!
    @IBOutlet weak private var pointMovieView: UIView!
    @IBOutlet weak private var pointMovieLabel: UILabel!
    @IBOutlet weak private var nameMovieLabel: UILabel!
    @IBOutlet weak private var premiereDateLabel: UILabel!
    var isAddGradientLayer = false
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollection()
        // Initialization code
    }
    func setUpCollection() {
        homeView.layer.cornerRadius = 8
        numberOfViewsView.layer.cornerRadius = 4
        numberOfViewsView.backgroundColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0.02352941176, alpha: 1).withAlphaComponent(0.17)
        pointMovieView.layer.borderColor = #colorLiteral(red: 0.1882352941, green: 0.7843137255, blue: 0.1764705882, alpha: 1)
        pointMovieView.layer.borderWidth = 3
        pointMovieView.layer.cornerRadius = pointMovieView.frame.height / 2
        nameMovieLabel.layer.shadowColor = #colorLiteral(red: 0.07058823529, green: 0.5882352941, blue: 0.8784313725, alpha: 1)
        nameMovieLabel.layer.shadowOpacity = 0.5
        nameMovieLabel.layer.shadowRadius = 1
        nameMovieLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        homeView.layer.cornerRadius = 10
        homeView.layer.borderWidth = 1
        homeView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
    }
    
    func setUpData(data: MovieEntity){
        nameMovieLabel.text = data.originalTitle
        premiereDateLabel.text = data.releaseDate
        numberOfviewsLabel.text = "\(data.voteCount ?? 0)"
        
        let pointAverage = Double(data.voteAverage!)
        let roundedNumber = (pointAverage * 100).rounded() / 100
        pointMovieLabel.text = "\(roundedNumber)"
        
        let linkUrlImage = "https://image.tmdb.org/t/p/w342" + (data.posterPath?.description ?? "alo")
        setImageFromStringrURL(stringUrl: linkUrlImage)
    }
    
    func setImageFromStringrURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            activityIndicator.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
            self.homeView.addSubview(activityIndicator)
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Error handling...
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.backgroundMoviesImageView.image = UIImage(data: imageData)
                    addBlackOverlay(to: self.backgroundMoviesImageView)
                    activityIndicator.stopAnimating()
                    
                }
            }.resume()
        }
        
        func addBlackOverlay(to imageView: UIImageView) {
            
            let topGradientLayer = CAGradientLayer()
            topGradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
            topGradientLayer.locations = [0.0, 0.3]
            topGradientLayer.frame = backgroundMoviesImageView.bounds
            
            let bottomGradientLayer = CAGradientLayer()
            bottomGradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            bottomGradientLayer.locations = [0.0, 1.0]
            bottomGradientLayer.frame = backgroundMoviesImageView.bounds
            
            if !isAddGradientLayer {
                backgroundMoviesImageView.layer.addSublayer(topGradientLayer)
                backgroundMoviesImageView.layer.addSublayer(bottomGradientLayer)
                isAddGradientLayer = true
            }
        }
    }
}
