//
//  InformationTableViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 18/11/2023.
//

import UIKit
protocol informationMovieDelegate: AnyObject {
    func nextRateReviesMovies(movieID: Int)
    func nextTrailerMovies(movieID: Int)
}

class InformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var pointReviewLabel: UILabel!
    @IBOutlet weak var dateMovieLabel: UILabel!
    @IBOutlet weak var timeMovieLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet private weak var reviewView: UIView!
    @IBOutlet private weak var playTrailerView: UIView!
    @IBOutlet weak var categoryStackView: UIStackView!
    
    var dataDetail: ListMovieDetailEntity?
    var dataCredit: ListCategoryResponseEntity?
    var dataCast: String = .empty
    var isAddGradientLayer = false
    var backInfo: Bool = false
    weak var delegateInformationMovie: informationMovieDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpView() {
        reviewView.layer.cornerRadius = 8
        playTrailerView.layer.cornerRadius = 8
    }
    
    func setUpData(data: ListMovieDetailEntity, credit: ListCategoryResponseEntity) {
        self.dataDetail = data
        nameMovieLabel.text = data.originalTitle
        
        let pointAverage = "\(data.voteAverage)"
        let a = pointAverage.prefix(3)
        pointReviewLabel.text = "\(a)"
        dateMovieLabel.text = data.releaseDate.toStringVnWith(fromDateFormat: Contants.dateFormatyyyyMMdd,
                                                              toDateFormat: Contants.yearFormatyyyy)
        timeMovieLabel.text = secondsToHoursMinutesSeconds(seconds: data.runtime)
        descriptionLabel.text = data.overview
        
        setupCastLabel(data: credit.cast)
        setupDirectorLabel(data: credit.crew)
        setupCategoryLabel(data: data)
        
        let linkUrlImage = "https://image.tmdb.org/t/p/w342" + (data.posterPath.description )
        setImageFromStringrURL(stringUrl: linkUrlImage)
    }
    
    func setupCategoryLabel(data: ListMovieDetailEntity) {
       removeAllSubview()
        for item in data.genres {
            let view = DetailCategoryView()
            view.loadContentViewWithNib(nibName: String(describing: DetailCategoryView.self))
            view.setupData(category: item.name)
            self.categoryStackView.addArrangedSubview(view)
        }
    }
    
    func removeAllSubview() {
        self.categoryStackView.subviews.forEach { subview in
            self.categoryStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    func setImageFromStringrURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.contentImageView.image = UIImage(data: imageData)
                    self.layoutIfNeeded()
                    self.addBlackOverlay(to: self.contentImageView)
                }
            }.resume()
        }
    }
    
    func addBlackOverlay(to imageView: UIImageView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0, 0.7]
        gradientLayer.frame = contentImageView.bounds
        
        if !isAddGradientLayer {
            contentImageView.layer.addSublayer(gradientLayer)
            isAddGradientLayer = true
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> String {
        let time = "\((seconds % 3600) / 60)h \((seconds % 3600) % 60)m"
        return time
    }
    
    func setupDirectorLabel(data: [ListCastResponseEntitty]) {
        for item in data where item.job == "Director" {
            directorLabel.text = "Director: \(item.name)"
        }
    }
    
    func setupCastLabel(data: [ListCastResponseEntitty]) {
        let dataCast = data.map { $0.name }
        castLabel.text = "Cast: \(dataCast.joined(separator: ", "))"
        self.dataCast =  "Cast: \(dataCast.joined(separator: ", "))"
        castLabel.numberOfLines = 1
        castLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(labelTapped))
        castLabel.addGestureRecognizer(tapGesture)
        if shouldAddMoreText(to: castLabel) {
            addMoreText(to: castLabel)
        }
    }
    
    @objc func labelTapped() {
        showFullLabel()
    }
    
    func showFullLabel() {
        castLabel.numberOfLines = 6
        castLabel.lineBreakMode = .byTruncatingTail
        castLabel.text = dataCast
        layoutIfNeeded()
    }
    
    @IBAction func rateReviewsMovie(_ sender: UIButton) {
        delegateInformationMovie?.nextRateReviesMovies(movieID: dataDetail?.id ?? 0)
    }
    
    @IBAction func playTrailerMovie(_ sender: UIButton) {
        delegateInformationMovie?.nextTrailerMovies(movieID: dataDetail?.id ?? 0)
    }
}

