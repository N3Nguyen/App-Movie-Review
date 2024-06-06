//
//  TabbarControll.swift
//  MovieNew
//
//  Created by QuocTN on 26/11/2023.
//

import UIKit

final class TabbarControll: UITabBarController {
    
    private var homeViewController: HomeMovieViewController = {
        let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreen") as! HomeMovieViewController
        homeViewController.tabBarItem.image = UIImage(named: "ic_home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        homeViewController.tabBarItem.selectedImage = UIImage(named: "ic_homeSellected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        homeViewController.tabBarItem.title = "Home"
        return homeViewController
    }()
    
    private var playingViewController: PlayingMovieViewController = {
        let playingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayingScreen") as! PlayingMovieViewController
        playingViewController.tabBarItem.image = UIImage(named: "ic_player-play")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        playingViewController.tabBarItem.title = "Playing"
        playingViewController.tabBarItem.selectedImage = UIImage(named: "ic_playingSellected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        return playingViewController
    }()

    private  var profileViewController: ProfileViewController = {
        let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileScreen") as! ProfileViewController
        
        profileViewController.tabBarItem.image = UIImage(named: "ic_user")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        profileViewController.tabBarItem.title = "Profile"
        profileViewController.tabBarItem.selectedImage = UIImage(named: "ic_userSellected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        return profileViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabbar()
        customTabbarTitle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customTabbarView()
    }
    
    private func setUpTabbar() {
        let homeNavigation = UINavigationController.init(rootViewController: homeViewController)
        let playingNavigation = UINavigationController.init(rootViewController: playingViewController)
        let profileNavigation = UINavigationController.init(rootViewController: profileViewController)
        
        self.viewControllers = [homeNavigation, playingNavigation, profileNavigation]
        tabBar.backgroundColor = ColorDefine.color1E1E1E
        tabBar.tintColor = ColorDefine.colorAAA6A6
        tabBar.layer.borderColor = ColorDefine.colorFD5151.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.cornerRadius = tabBar.bounds.height / 2
        selectedIndex = 0
    }
    
    private func customTabbarView() {
        let tabBarHeight: CGFloat = 64
        let tabBarPadding: CGFloat = 45
        let tabBarWidth = view.bounds.width - (2 * tabBarPadding)
        let tabBarX = tabBarPadding
        let tabBarY = view.bounds.height - tabBarHeight - 30
        tabBar.frame = CGRect(x: tabBarX, y: tabBarY, width: tabBarWidth, height: tabBarHeight)
        tabBar.layer.cornerRadius = tabBar.bounds.height / 2
    }
    
    private func customTabbarTitle() {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: AppConstants.FontQuickSans.demiBold.fontSize(14),
                                                                           NSAttributedString.Key.foregroundColor: ColorDefine.colorFD5151]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: AppConstants.FontQuickSans.demiBold.fontSize(12),
                                                                         NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        tabBar.standardAppearance = appearance
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 3, bottom: 1, right: 3)
    }
}
