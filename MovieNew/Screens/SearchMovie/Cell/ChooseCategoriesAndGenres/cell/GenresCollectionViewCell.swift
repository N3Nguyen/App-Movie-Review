//
//  GenresCollectionViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 24/01/2024.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homeViewCell: UIView!
    @IBOutlet weak var titleGenresLabel: UILabel!
    var indexCell: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func setUpView() {
        homeViewCell.layer.cornerRadius = 15
        homeViewCell.layer.borderWidth = 2
        homeViewCell.layer.borderColor = #colorLiteral(red: 0.6666666667, green: 0.6509803922, blue: 0.6509803922, alpha: 1)
    }
    
    func bindData(data: ListGenresResponseEntity, indexCell: Int) {
        titleGenresLabel.text = data.genres[indexCell].name
    }
}
