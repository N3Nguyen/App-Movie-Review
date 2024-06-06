
//
//  CategoryGenresTableViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 20/11/2023.
//

import UIKit

class CategoryGenresTableViewCell: UITableViewCell {

    @IBOutlet private weak var categoriesView: UIView!
    @IBOutlet private weak var genresView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpView() {
        categoriesView.layer.cornerRadius = 10
        categoriesView.layer.borderColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        categoriesView.layer.borderWidth = 1
        
        genresView.layer.cornerRadius = 10
        genresView.layer.borderColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        genresView.layer.borderWidth = 1
    }
    @IBAction func didSelectCategories(_ sender: UIButton) {
    }
    @IBAction func didSelectGeres(_ sender: UIButton) {
    }
}
