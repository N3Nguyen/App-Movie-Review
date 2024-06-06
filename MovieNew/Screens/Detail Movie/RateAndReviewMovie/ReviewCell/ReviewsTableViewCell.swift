import UIKit

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var homeViewCell: UIView!
    @IBOutlet weak var viewUser: UIView!
    @IBOutlet weak var starView: UIView!
    @IBOutlet weak var nameUserReviewLabel: UILabel!
    @IBOutlet weak var pointReviewLabel: UILabel!
    @IBOutlet weak var dateReviewLabel: UILabel!
    @IBOutlet weak var commentReviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpView() {
        homeViewCell.layer.borderWidth = 1
        homeViewCell.layer.borderColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 0.05)
        homeViewCell.layer.cornerRadius = 12
        starView.layer.cornerRadius = 4
        viewUser.layer.cornerRadius = 16
    }
    
    func bindData(data: ListTitleResult) {
        let rating = data
        nameUserReviewLabel.text = data.author
        let number: Float = Float(data.authorDetails?.rating ?? 0)
        if number != 0.0 {
            pointReviewLabel.text = String(number)
        } else {
            pointReviewLabel.text = "0.0"
        }
        
        let dateString = data.createdAt ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = dateFormatter.date(from: dateString) {
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM d, yyyy"
            let formattedDateString = dateFormatterPrint.string(from: date)
            dateReviewLabel.text = "on \(formattedDateString)"
        } else {
            print("Không thể chuyển đổi ngày tháng.")
        }
        commentReviewLabel.text = data.content
    }
    
    
}
