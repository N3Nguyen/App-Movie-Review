
import UIKit
import AVFoundation
import AVKit
class DetailMovieViewController: BaseViewController {
    
    @IBOutlet private weak var detalMovieTableView: UITableView!
    @IBOutlet private weak var bookNowButton: UIButton!
    
    var model = DetailMovieModel()
    var movieID: Int = 0
    var backInfo: Bool = false
    var playerViewController = AVPlayerViewController()
    var videoID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMenuStackView()
        setUpTableView()
        getDetailMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        animateTabBar(hidden: true)
    }
    
    private func getDetailMovie() {
        model.onGetDataSuccess = { [weak self] () in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
            self.detalMovieTableView.reloadData()
        }
        
        model.onGetDataFail = { [weak self] (error: NetworkServiceError) in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
            self.detalMovieTableView.reloadData()
        }
        
        self.didGetData = false
        self.displayActivityIndicatorView(display: true)
        self.model.requestMainData(movieID: movieID)
        
    }
    
    func setUpMenuStackView() {
        bookNowButton.layer.cornerRadius = 32
    }
    
    func setUpTableView() {
        detalMovieTableView.dataSource = self
        detalMovieTableView.delegate = self
        let nibListMore = UINib(nibName: "ListMoreMovieTableViewCell", bundle: nil)
        detalMovieTableView.register(nibListMore, forCellReuseIdentifier: "ListMoreMovieTableViewCell")
        let nibInformation = UINib(nibName: "InformationTableViewCell", bundle: nil)
        detalMovieTableView.register(nibInformation, forCellReuseIdentifier: "InformationTableViewCell")
        let heightTabBar = navigationController?.navigationBar.frame.size.height
        detalMovieTableView.contentInset = UIEdgeInsets(top: -(heightTabBar ?? 0), left: 0, bottom: 0, right: 0)
        detalMovieTableView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    @IBAction func backScreen(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navitoDetailScreen(movieID: Int) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailMovie") as? DetailMovieViewController
        detailVC?.movieID = movieID
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
    
    func gotoDetailMovie(movieID: Int) {
        navitoDetailScreen(movieID: movieID)
    }
}

extension DetailMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 500
        } else {
            return 950
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InformationTableViewCell.self)) as! InformationTableViewCell
            if didGetData == true, let data = model.listMovieDetailEntity, let credit = model.listCategory {
                cell.delegateInformationMovie = self
                cell.setUpData(data: data, credit: credit)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListMoreMovieTableViewCell.self)) as! ListMoreMovieTableViewCell
            if didGetData == true, let data = model.listSimilarMovies {
                cell.setUpData(data: data , didGetData: true)
                cell.delegateReloadMovies = self
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !didGetData {
            isStartAnimation(isStart: true)
        }
    }
}

extension DetailMovieViewController: reloadDetailMoviesDelegate {
    func reloadDetailMovie(movieID: Int) {
        self.movieID = movieID
        getDetailMovie()
        let indexPath = IndexPath(row: 0, section: 0)
        self.detalMovieTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    func isStartAnimation(didGetData: Bool) {
        if !didGetData {
            isStartAnimation(isStart: true)
        }
    }
}

extension DetailMovieViewController: informationMovieDelegate, AVPlayerViewControllerDelegate {
    func nextRateReviesMovies(movieID: Int) {
        let rateReviewStoryboard = storyboard?.instantiateViewController(withIdentifier: "RateAndReviewMovie") as? RateAndReviewMovieViewController
        rateReviewStoryboard?.movieID = movieID
        self.navigationController?.pushViewController(rateReviewStoryboard!, animated: true)
    }
    
    func nextTrailerMovies(movieID: Int) {
        videoID = "1QLQCfw5lAM"
        guard let videoID = videoID else {
            print("Video ID is nil")
            return
        }
        guard let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else {
            print("Invalid video URL")
            return
        }
        let playerItem = AVPlayerItem(url: videoURL)
        let player = AVPlayer(playerItem: playerItem)
        playerViewController.player = player
        present(playerViewController, animated: true) {
            self.playerViewController.player?.play()
        }
    }
}

