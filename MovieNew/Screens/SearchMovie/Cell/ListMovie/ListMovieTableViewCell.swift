//
//  ListMovieTableViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 20/11/2023.
//

import UIKit
protocol ListSearchMoviesCellDelegate: AnyObject {
    func gotoDiscoverDetailMovie(movieID: Int)
}

class ListMovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var listMovieSearchCollectionView: UICollectionView!
    private var discoverData: ListMovies?
    private var didGetData: Bool = false
    weak var delegateListSearch: ListSearchMoviesCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setUpCollectionView() {
        listMovieSearchCollectionView.delegate = self
        listMovieSearchCollectionView.dataSource = self
        
        let nibList = UINib(nibName: "DiscoverMovieCollectionViewCell", bundle: nil)
        listMovieSearchCollectionView.register(nibList, forCellWithReuseIdentifier: "DiscoverMovieCollectionViewCell")
    }
    
    func setUpData(data: ListMovies) {
        discoverData = data
        listMovieSearchCollectionView.reloadData()
    }
}

extension ListMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoverData?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = listMovieSearchCollectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverMovieCollectionViewCell", for: indexPath) as? DiscoverMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let data = discoverData {
            didGetData = true
            cell.setUpData(data: data.results[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didGetData, let data =  discoverData {
            delegateListSearch?.gotoDiscoverDetailMovie(movieID: data.results[indexPath.row].id ?? 0)
        }
    }
}

extension ListMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:listMovieSearchCollectionView.frame.width / 2.0 - 6, height: 220)
    }
}
