//
//  TrailerScreenViewController.swift
//  MovieNew
//
//  Created by QuocTN on 12/04/2024.
//

import UIKit
import AVFoundation
import AVKit
class TrailerScreenViewController: BaseViewController, AVPlayerViewControllerDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playVideoView: UIView!
    
    var playerViewController = AVPlayerViewController()
    var videoID: String?
    
    var model = TrailerMovieModel()
    var movieID: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getTrailerMovie()
        setUpPlay()
    }
    
    private func getTrailerMovie() {
        model.onGetDataSuccess = { [weak self] () in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
        }
        
        model.onGetDataFail = { [weak self] (error: NetworkServiceError) in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
        }
        
        self.didGetData = false
        self.displayActivityIndicatorView(display: true)
        self.model.requestMainData(movieID: movieID)
    }
    
    func setUpPlay() {
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
    
    @IBAction func backDetal(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
