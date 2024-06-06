//
//  ChooseCategoriesViewController.swift
//  MovieNew
//
//  Created by QuocTN on 20/01/2024.
//

import UIKit
protocol ChooseCategoriesDelegate: AnyObject {
    func didSelectCategory(_ category: String)
}
class ChooseCategoriesViewController: UIViewController {
    
    @IBOutlet var homeView: UIView!
    @IBOutlet weak var chooseCateView: UIView!
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var lastestButton: UIButton!
    @IBOutlet weak var upCommingButton: UIButton!
    @IBOutlet weak var nowPlayingButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var popularView: UIView!
    @IBOutlet weak var lastView: UIView!
    @IBOutlet weak var upCommingView: UIView!
    @IBOutlet weak var nowPlayingView: UIView!
    
    weak var delegateCategory: ChooseCategoriesDelegate?
    var chooseApply: Bool = false
    var textCategories: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        chooseCateView.layer.cornerRadius = 32
        popularButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        lastestButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        upCommingButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        nowPlayingButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        popularView.layer.cornerRadius = 8
        lastView.layer.cornerRadius = 8
        upCommingView.layer.cornerRadius = 8
        nowPlayingView.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 12
        applyButton.layer.cornerRadius = 12
        
    }
    
    @IBAction func choosePopular(_ sender: UIButton) {
        textCategories = "Popular"
        popularView.layer.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
        lastView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        upCommingView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        nowPlayingView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        chooseApply = true
    }
    
    @IBAction func chooseLastest(_ sender: UIButton) {
        textCategories = "Latest"
        popularView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        lastView.layer.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
        upCommingView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        nowPlayingView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        chooseApply = true
    }
    
    @IBAction func chooseUpComming(_ sender: UIButton) {
        textCategories = "Up Comming"
        popularView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        lastView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        upCommingView.layer.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
        nowPlayingView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        chooseApply = true
    }
    
    @IBAction func choosePlaying(_ sender: UIButton) {
        textCategories = "Playing"
        popularView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        lastView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        upCommingView.layer.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7254901961, blue: 0.7411764706, alpha: 0.2)
        nowPlayingView.layer.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
        chooseApply = true
    }
    
    @IBAction func clickCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        cancelButton.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
        cancelButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        applyButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        applyButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction func clickApply(_ sender: UIButton) {
        if chooseApply {
            delegateCategory?.didSelectCategory(textCategories)
        } else {
            delegateCategory?.didSelectCategory("...")
        }
        self.dismiss(animated: true, completion: nil)
        applyButton.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
        applyButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cancelButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cancelButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}


