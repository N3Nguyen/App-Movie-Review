//
//  homeMovieViewController.swift
//  MovieNew
//
//  Created by QuocTN on 12/11/2023.
//

import UIKit

class HomeMovieViewController: BaseViewController {
    
    @IBOutlet private weak var homeMovieTableView: UITableView!
    
    let model: HomeScreenModel = HomeScreenModel()
    var movieID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getHomeMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animateTabBar(hidden: false)
        }
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setUpTableView() {
        homeMovieTableView.dataSource = self
        homeMovieTableView.delegate = self
        let nibTrending = UINib(nibName: "TrendingMovieTableViewCell", bundle: nil)
        homeMovieTableView.register(nibTrending, forCellReuseIdentifier: "TrendingMovieTableViewCell")
        let nibCommingSoon = UINib(nibName: "CommingSoonMovieTableViewCell", bundle: nil)
        homeMovieTableView.register(nibCommingSoon, forCellReuseIdentifier: "CommingSoonMovieTableViewCell")
    }
    
    func getHomeMovie() {
        model.onGetDataSuccess = { [weak self] () in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
            self.homeMovieTableView.reloadData()
        }
        
        model.onGetDataFail = { [weak self] (error: NetworkServiceError) in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
            self.homeMovieTableView.reloadData()
        }
        
        
        self.didGetData = false
        self.displayActivityIndicatorView(display: true)
        self.model.requestMainData()
    }
    
    func navitoDetailScreen(movieID: Int) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailMovie") as! DetailMovieViewController
        detailVC.movieID = movieID
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
// MARK: - UITableViewDelegate
extension HomeMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            navitoDetailScreen(movieID: model.listCommingSoonData?.results[indexPath.row].id ?? 10)
        default:
            break
        }
    }
}

extension HomeMovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return model.listCommingSoonData?.results.count ?? 3
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let label = UILabel()
        if section == 0 {
            label.text = "Trending"
        } else {
            label.text = "Comming soon"
        }
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 234
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            guard let cell = homeMovieTableView.dequeueReusableCell(withIdentifier: "TrendingMovieTableViewCell", for: indexPath) as? TrendingMovieTableViewCell else {
                return UITableViewCell()
            }
            if didGetData == true, let data = model.listTrendingData, let dataGenres = model.listGenresData {
                cell.delegateHomeTrending = self
                cell.setUpData(data: data, dataGenres: dataGenres)
            }
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = homeMovieTableView.dequeueReusableCell(withIdentifier: "CommingSoonMovieTableViewCell", for: indexPath) as? CommingSoonMovieTableViewCell else {
                return UITableViewCell()
            }
            if didGetData == true, let data = model.listCommingSoonData {
                cell.bindData(data: data, indexCell: indexPath.row)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !didGetData {
            isStartAnimation(isStart: true)
        }
    }
}

extension HomeMovieViewController: HomeTrenddingCellDelegate {
    func gotoDetailMovie(movieID: Int) {
        navitoDetailScreen(movieID: movieID)
    }
}

extension HomeMovieViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            animateTabBar(hidden: true)
        } else {
            animateTabBar(hidden: false)
        }
    }
}
