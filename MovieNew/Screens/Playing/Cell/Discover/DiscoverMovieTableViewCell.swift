//
//  discoverTableViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 16/11/2023.
//

import UIKit
protocol DiscoverCellDelegate: AnyObject {
    func gotoDiscoverDetailMovie(movieID: Int)
}

class DiscoverMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var discoverCollectionView: UICollectionView!
    
    var discoverData: ListMovies?
    weak var delegateDiscover: DiscoverCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCollectionView() {
        discoverCollectionView.delegate = self
        discoverCollectionView.dataSource = self
        
        let nibList = UINib(nibName: "DiscoverMovieCollectionViewCell", bundle: nil)
        discoverCollectionView.register(nibList, forCellWithReuseIdentifier: "DiscoverMovieCollectionViewCell")
    }
    
    func setUpData(data: ListMovies) {
        discoverData = data
        discoverCollectionView.reloadData()
    }
}
extension DiscoverMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoverData?.results.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = discoverCollectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverMovieCollectionViewCell", for: indexPath) as? DiscoverMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let data = discoverData {
            cell.setUpData(data: data.results[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data =  discoverData {
            delegateDiscover?.gotoDiscoverDetailMovie(movieID: data.results[indexPath.row].id ?? 0)
        }
    }
}

extension DiscoverMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:discoverCollectionView.frame.width / 2.0 - 6, height: 220)
    }
}
