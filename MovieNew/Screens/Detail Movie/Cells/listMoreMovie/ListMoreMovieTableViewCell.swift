//
//  ListMoreMovieTableViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 19/11/2023.
//

import UIKit
protocol reloadDetailMoviesDelegate: AnyObject {
    func reloadDetailMovie(movieID: Int)
    func isStartAnimation(didGetData: Bool)
}

class ListMoreMovieTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var listMovieCollectionView: UICollectionView!
    weak var delegateReloadMovies: reloadDetailMoviesDelegate?
    
    var SimilarMoviesData: [MovieEntity]?
    var didGetData = false
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCollectionView() {
        listMovieCollectionView.delegate = self
        listMovieCollectionView.dataSource = self
        
        let nibList = UINib(nibName: "DiscoverMovieCollectionViewCell", bundle: nil)
        listMovieCollectionView.register(nibList, forCellWithReuseIdentifier: "DiscoverMovieCollectionViewCell")
    }
    func setUpData(data: [MovieEntity], didGetData: Bool) {
        self.didGetData = didGetData
        SimilarMoviesData = data
        listMovieCollectionView.reloadData()
    }
}

extension ListMoreMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if didGetData {
            return SimilarMoviesData?.count ?? 3
        } else {
            return 3
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = listMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverMovieCollectionViewCell", for: indexPath) as? DiscoverMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if didGetData == true, let data = SimilarMoviesData {
            cell.setUpData(data: data[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didGetData == true , let data = SimilarMoviesData {
            self.delegateReloadMovies?.reloadDetailMovie(movieID: data[indexPath.row].id ?? 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegateReloadMovies?.isStartAnimation(didGetData: didGetData)
    }
}
extension ListMoreMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:listMovieCollectionView.frame.width / 3.0 - 12 , height: 200)
    }
}
