//
//  userTableViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 17/11/2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet private weak var imageUserView: UIView!
    @IBOutlet weak var nameAccLabel: UILabel!
    @IBOutlet weak var idAccLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpView() {
        imageUserView.layer.cornerRadius = 60
        nameAccLabel.text = UserDefaults.standard.string(forKey: "statusAcc")
    }
}
