//
//  AcountUserTableViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 17/11/2023.
//

import UIKit

class AcountUserTableViewCell: UITableViewCell {

    @IBOutlet weak var stackView: UIView!
    @IBOutlet private weak var acountView: UIView!
    @IBOutlet private weak var memberView: UIView!
    @IBOutlet private weak var changePasswordView: UIView!
    @IBOutlet private weak var editProfileInfoView: UIView!
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
        stackView.layer.cornerRadius = 12
        stackView.layer.masksToBounds = true
        stackView.layer.borderWidth = 1
        stackView.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        stackView.layer.shadowOpacity = 0.5
        stackView.layer.shadowRadius = 1
        stackView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        memberView.layer.cornerRadius = 12
        changePasswordView.layer.cornerRadius = 12
        editProfileInfoView.layer.cornerRadius = 12
    }
    
    @IBAction func clickMember(_ sender: UIButton) {
    }
    
    @IBAction func clickChangePass(_ sender: UIButton) {
    }
    
    @IBAction func clickEditProfile(_ sender: UIButton) {
    }
}
