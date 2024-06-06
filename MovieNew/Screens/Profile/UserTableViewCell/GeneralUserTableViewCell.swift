//
//  GeneralUserTableViewCell.swift
//  MovieNew
//
//  Created by QuocTN on 17/11/2023.
//

import UIKit
protocol GeneralDelegate: AnyObject {
    func backLogin()
}

class GeneralUserTableViewCell: UITableViewCell {

    @IBOutlet private weak var stackView: UIView!
    @IBOutlet private weak var generalView: UIView!
    @IBOutlet private weak var notificationView: UIView!
    @IBOutlet private weak var languageView: UIView!
    @IBOutlet private weak var reviewView: UIView!
    @IBOutlet private weak var logOutView: UIView!
    
    let selectedIndex = 0
    let userDefaults = UserDefaults.standard
    weak var delegateGeneral: GeneralDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func setUpView() {
        stackView.layer.cornerRadius = 12
        stackView.layer.masksToBounds = true
        stackView.layer.borderWidth = 1
        stackView.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        stackView.layer.shadowOpacity = 0.5
        stackView.layer.shadowRadius = 1
        stackView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        notificationView.layer.cornerRadius = 12
        languageView.layer.cornerRadius = 12
        reviewView.layer.cornerRadius = 12
        logOutView.layer.cornerRadius = 12
    }
    
    @IBAction func notificationSwitch(_ sender: UISwitch) {
    }
    
    @IBAction func changeLanguage(_ sender: UIButton) {
    }
    
    @IBAction func historyReview(_ sender: UIButton) {
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        delegateGeneral?.backLogin()
        userDefaults.removeObject(forKey: "statusAcc")
        userDefaults.set(false, forKey: "isLoggedIn")
        userDefaults.set(false, forKey: "isChangingMenu")
    }
}
