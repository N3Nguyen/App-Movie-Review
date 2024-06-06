import UIKit

class ListMovieEmptyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func setUpView() {
        cellView.layer.cornerRadius = 8
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3029942797)
    }
}
