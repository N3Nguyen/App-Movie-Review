import UIKit

class NowPlayingIsAllTableViewCell: UITableViewCell {
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var backgroundMovieImageView: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    
    var indexCell: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundMovieImageView.layer.borderWidth = 1
        backgroundMovieImageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        backgroundMovieImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindDataAll(data: ListMovies, indexCell: Int) {
        let monthMovie = monthReleaseDateMovie(data: data.results[indexCell].releaseDate  ?? "0")
        changeReleaseDateMovie(data: monthMovie.description)
        dayLabel.text = dayReleaseDateMovie(data: data.results[indexCell].releaseDate  ?? "0")
        nameMovieLabel.text = data.results[indexCell].title
        let linkUrlImage = "https://image.tmdb.org/t/p/w500" + (data.results[indexCell].backdropPath ?? "")
        setImageFromStringrURL(stringUrl: linkUrlImage)
    }
    
    func changeReleaseDateMovie(data: String) {
        switch data {
        case "01": monthLabel.text = "Jan"
        case "02": monthLabel.text = "Feb"
        case "03": monthLabel.text = "Mar"
        case "04": monthLabel.text = "Apr"
        case "05": monthLabel.text = "May"
        case "06": monthLabel.text = "June"
        case "07": monthLabel.text = "July"
        case "08": monthLabel.text = "Aug"
        case "09": monthLabel.text = "Sep"
        case "10": monthLabel.text = "Oct"
        case "11": monthLabel.text = "Nov"
        case "12": monthLabel.text = "Dec"
        default:
            print("")
        }
    }
    
    func dayReleaseDateMovie(data: String) -> String {
        let substring = String(data.suffix(2))
        return substring
    }
    
    func monthReleaseDateMovie(data: String) -> String {
        let monthSubstring = data.suffix(5).prefix(2)
        return String(monthSubstring)
    }
    
    func setImageFromStringrURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            activityIndicator.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
            self.viewCell.addSubview(activityIndicator)
            contentMode = .scaleToFill
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Error handling...
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.backgroundMovieImageView.image = UIImage(data: imageData)
                    activityIndicator.stopAnimating()
                }
            }.resume()
        }
    }
}
