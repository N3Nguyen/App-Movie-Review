import UIKit
import Foundation

class RateAndReviewMovieViewController: BaseViewController {
    
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var userReviewView: UIView!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var nameUserReview: UILabel!
    
    @IBOutlet var starButtons: [UIButton]!
    
    var model = DetailMovieModel()
    var movieID: Int = 0
    var indexStar: Int = 0
    let placeholderLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getReviewsMovie()
        setUpView()
        setUpTableView()
        setUpStarButtons()
        setUpTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        animateTabBar(hidden: true)
    }
    
    
    
    private func getReviewsMovie() {
        model.onGetDataSuccess = { [weak self] () in
            guard let self = self else {
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.didGetData = true
                self.displayActivityIndicatorView(display: false)
                self.reviewsTableView.reloadData()
            }
        }
        
        model.onGetDataFail = { [weak self] (error: NetworkServiceError) in
            guard let self = self else {
                return
            }
            self.didGetData = true
            self.displayActivityIndicatorView(display: false)
            self.reviewsTableView.reloadData()
        }
        
        self.didGetData = false
        self.displayActivityIndicatorView(display: true)
        model.requestMainDataReview(movieID: movieID)
    }
    
    func setUpView() {
        userReviewView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        userReviewView.layer.cornerRadius = 32
        userReviewView.layer.masksToBounds = false
        userReviewView.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1464906402)
        userReviewView.layer.shadowOpacity = 0.5
        userReviewView.layer.shadowOffset = CGSize(width: 0, height: -5)
        userReviewView.layer.shadowRadius = 3
        userReviewView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1464906402)
        userReviewView.layer.borderWidth = 1
        
        reviewTextView.layer.cornerRadius = 12
        sendButton.layer.cornerRadius = 8
        
        nameUserReview.text = "A review by " + (UserDefaults.standard.string(forKey: "statusAcc") ?? "")
    }
    
    func setUpTableView() {
        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self
        let nibListReviews = UINib(nibName: "ReviewsTableViewCell", bundle: nil)
        reviewsTableView.register(nibListReviews, forCellReuseIdentifier: "ReviewsTableViewCell")
    }
    
    func setUpTextView() {
        placeholderLabel.text = "Write your review"
        placeholderLabel.textColor = #colorLiteral(red: 0.4156862745, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewTextView.addSubview(placeholderLabel)
        placeholderLabel.leadingAnchor.constraint(equalTo: reviewTextView.leadingAnchor, constant: 5).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: reviewTextView.topAnchor, constant: 8).isActive = true
        reviewTextView.delegate = self
        placeholderLabel.isHidden = !reviewTextView.text.isEmpty
    }
    
    func setUpStarButtons() {
        for button in starButtons {
            button.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        }
        updateStarButtons()
    }
    
    @objc func starButtonTapped(_ sender: UIButton) {
        indexStar = sender.tag
        updateStarButtons()
    }
    
    func updateStarButtons() {
        for (index, button) in starButtons.enumerated() {
            button.setImage(index < indexStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        }
    }
    
    @IBAction func backDetailMovie(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RateAndReviewMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.listReviewsMovie?.results?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReviewsTableViewCell.self)) as! ReviewsTableViewCell
        if didGetData == true, let data = model.listReviewsMovie {
            cell.bindData(data: data.results![indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !didGetData {
            isStartAnimation(isStart: true)
        }
    }
}

extension RateAndReviewMovieViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
