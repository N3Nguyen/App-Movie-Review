//
//  trendingTableViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 13/11/2023.
//

import UIKit
protocol HomeTrenddingCellDelegate: AnyObject {
    func gotoDetailMovie(movieID: Int)
}

class TrendingMovieTableViewCell: UITableViewCell {

    @IBOutlet weak private var trendingCollectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var collectionviewLeftContraint: NSLayoutConstraint!
    var trendingData: ListMovies?
    var genresData: ListGenresResponseEntity?
    weak var delegateHomeTrending: HomeTrenddingCellDelegate?
    let flowLayout = ZoomAndSnapFlowLayout()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        collectionviewLeftContraint.constant = -20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCollectionView() {
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        
        let nibList = UINib(nibName: "TrendingMovieCollectionViewCell", bundle: nil)
        trendingCollectionView.register(nibList, forCellWithReuseIdentifier: "TrendingMovieCollectionViewCell")
        trendingCollectionView.collectionViewLayout = flowLayout
        trendingCollectionView.contentInsetAdjustmentBehavior = .always
        pageControll.numberOfPages = trendingData?.results.count ?? 0
        pageControll.currentPage = 0
        pageControll.pageIndicatorTintColor = .gray
        pageControll.currentPageIndicatorTintColor = .white
    }
    func setUpData(data: ListMovies, dataGenres: ListGenresResponseEntity) {
        genresData = dataGenres
        trendingData = data
        pageControll.numberOfPages = data.results.count
        trendingCollectionView.reloadData()
    }
}
extension TrendingMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingData?.results.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trendingCollectionView.dequeueReusableCell(withReuseIdentifier: "TrendingMovieCollectionViewCell", for: indexPath) as? TrendingMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let data = trendingData, let dataGenres = genresData {
            cell.getDataMovieTreding(data: data.results[indexPath.row], indexCell: indexPath.row, genresMovie: dataGenres)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  let data = trendingData {
            delegateHomeTrending?.gotoDetailMovie(movieID: data.results[indexPath.row].id ?? 0)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = trendingCollectionView else { return }
        let visibleCenterX = collectionView.contentOffset.x + collectionView.bounds.width / 2
        if let indexPath = collectionView.indexPathForItem(at: CGPoint(x: visibleCenterX, y: collectionView.bounds.height / 2)) {
            let pageIndex = indexPath.item
            pageControll.currentPage = pageIndex
            if pageIndex == 0 {
                collectionviewLeftContraint.constant = -20
                layoutIfNeeded()
            } else {
                collectionviewLeftContraint.constant = 0
                layoutIfNeeded()
            }
        }
    }
}

extension TrendingMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}
