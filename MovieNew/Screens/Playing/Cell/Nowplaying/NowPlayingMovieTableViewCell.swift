//
//  nowPlayingTableViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 16/11/2023.
//

import UIKit
protocol NowPlayingCellDelegate: AnyObject {
    func gotoDetailMovie(movieID: Int)
}

class NowPlayingMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingView: UIView!
    @IBOutlet weak var collectionviewLeftContraint: NSLayoutConstraint!
    
    var nowPlayingData: ListMovies?
    var didGetData: Bool = false
    let flowLayout = ZoomAndSnapFlowLayout()
    weak var delegateNowPlaying: NowPlayingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        collectionviewLeftContraint.constant = -20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCollectionView() {
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        
        let nibList = UINib(nibName: "NowPlayingMovieCollectionViewCell", bundle: nil)
        nowPlayingCollectionView.register(nibList, forCellWithReuseIdentifier: "NowPlayingMovieCollectionViewCell")
        nowPlayingCollectionView.collectionViewLayout = flowLayout
        nowPlayingCollectionView.contentInsetAdjustmentBehavior = .always
    }
    
    func setUpData(data: ListMovies) {
        nowPlayingData = data
        nowPlayingCollectionView.reloadData()
    }
}

extension NowPlayingMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingData?.results.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = nowPlayingCollectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMovieCollectionViewCell", for: indexPath) as? NowPlayingMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let data = nowPlayingData {
            cell.bindDataNowPlaying(data: data.results[indexPath.row], indexCell: indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data =  nowPlayingData {
            delegateNowPlaying?.gotoDetailMovie(movieID: data.results[indexPath.row].id ?? 0)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = nowPlayingCollectionView else { return }
        let visibleCenterX = collectionView.contentOffset.x + collectionView.bounds.width / 2
        if let indexPath = collectionView.indexPathForItem(at: CGPoint(x: visibleCenterX, y: collectionView.bounds.height / 2)) {
            let pageIndex = indexPath.item
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

extension NowPlayingMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}
