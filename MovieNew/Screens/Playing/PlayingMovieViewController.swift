import UIKit

class PlayingMovieViewController: BaseViewController {
    
    @IBOutlet private weak var playingTableView: UITableView!
    
    let model: PLayingScreenModel = PLayingScreenModel()
    var tableViewDisplay: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getPlayMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setUpTableView() {
        playingTableView.dataSource = self
        playingTableView.delegate = self
        let nibNowPlaying = UINib(nibName: "NowPlayingMovieTableViewCell", bundle: nil)
        playingTableView.register(nibNowPlaying, forCellReuseIdentifier: "NowPlayingMovieTableViewCell")
        let nibDiscover = UINib(nibName: "DiscoverMovieTableViewCell", bundle: nil)
        playingTableView.register(nibDiscover, forCellReuseIdentifier: "DiscoverMovieTableViewCell")
        let nibCommingSoon = UINib(nibName: "CommingSoonMovieTableViewCell", bundle: nil)
        playingTableView.register(nibCommingSoon, forCellReuseIdentifier: "CommingSoonMovieTableViewCell")
    }
    
    func getPlayMovie() {
        model.onGetDataSuccess = { [weak self] () in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
            self.playingTableView.reloadData()
        }
        
        model.onGetDataFail = { [weak self] (error: NetworkServiceError) in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
            self.playingTableView.reloadData()
        }
        
        self.didGetData = false
        self.displayActivityIndicatorView(display: true)
        self.model.requestMainData()
    }
    
    func navitoDetailScreen(movieID: Int) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailMovie") as! DetailMovieViewController
        detailVC.movieID = movieID
        self.navigationController?.pushViewController(detailVC, animated: false)
    }
    
    @objc func buttonTapped() {
        tableViewDisplay = !tableViewDisplay
        playingTableView.reloadData()
    }
    
    @IBAction func goSearchScreen(_ sender: UIButton) {
        let searchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchScreen") as! SearchMovieViewController
        self.navigationController?.pushViewController(searchVC, animated: false)
    }
}

extension PlayingMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableViewDisplay {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewDisplay {
            return model.listMoviesNowPlaying?.results.count ?? 10
        } else {
            if section == 0 {
                return 1
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableViewDisplay {
            let headerView = UIView()
            let label = UILabel()
            label.text = "Now playing"
            let button = UIButton(type: .system)
            button.setTitle("All", for: .normal)
            button.frame = CGRect(x: UIScreen.main.bounds.size.width - 60, y: 0, width: 80, height: 30)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            headerView.addSubview(button)
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            headerView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
                label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            return headerView
        } else {
            let headerView = UIView()
            let label = UILabel()
            if section == 0 {
                label.text = "Now playing"
                let button = UIButton(type: .system)
                button.setTitle("All", for: .normal)
                button.frame = CGRect(x: UIScreen.main.bounds.size.width - 60, y: 0, width: 80, height: 30)
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                
                headerView.addSubview(button)
            } else {
                label.text = "Discover"
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
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableViewDisplay {
            return UITableView.automaticDimension
        } else {
            if indexPath.row == 0 && indexPath.section == 0 {
                return 234
            } else {
                return 2320
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableViewDisplay {
            guard let cell = playingTableView.dequeueReusableCell(withIdentifier: "CommingSoonMovieTableViewCell", for: indexPath) as? CommingSoonMovieTableViewCell else {
                return UITableViewCell()
            }
            if didGetData == true, let data = model.listMoviesNowPlaying {
                cell.bindData(data: data, indexCell: indexPath.row)
            }
            cell.selectionStyle = .none
            return cell
        } else {
            if indexPath.row == 0 && indexPath.section == 0 {
                guard let cell = playingTableView.dequeueReusableCell(withIdentifier: "NowPlayingMovieTableViewCell", for: indexPath) as? NowPlayingMovieTableViewCell else {
                    return UITableViewCell()
                }
                if didGetData, let data = model.listMoviesNowPlaying {
                    cell.setUpData(data: data)
                    cell.delegateNowPlaying = self
                }
                return cell
            } else {
                guard let cell = playingTableView.dequeueReusableCell(withIdentifier: "DiscoverMovieTableViewCell", for: indexPath) as? DiscoverMovieTableViewCell else {
                    return UITableViewCell()
                }
                if didGetData, let data = model.listMoviesDiscover {
                    cell.setUpData(data: data)
                    cell.delegateDiscover = self
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !didGetData {
            isStartAnimation(isStart: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewDisplay {
            navitoDetailScreen(movieID: model.listMoviesNowPlaying?.results[indexPath.row].id ?? 0)
        }
    }
}
 
extension PlayingMovieViewController: NowPlayingCellDelegate {
    func gotoDetailMovie(movieID: Int) {
        navitoDetailScreen(movieID: movieID)
    }
}

extension PlayingMovieViewController: DiscoverCellDelegate {
    func gotoDiscoverDetailMovie(movieID: Int) {
        navitoDetailScreen(movieID: movieID)
    }
}

extension PlayingMovieViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            animateTabBar(hidden: true)
        } else {
            animateTabBar(hidden: false)
        }
    }
}
