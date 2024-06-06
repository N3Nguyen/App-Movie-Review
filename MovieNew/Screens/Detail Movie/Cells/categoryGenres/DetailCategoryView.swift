import UIKit

class DetailCategoryView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadContentViewWithNib(nibName: String(describing: DetailCategoryView.self))
    }
    
    func loadContentViewWithNib(nibName: String) {
        backgroundColor = UIColor.clear
        if contentView == nil {
            contentView = self.loadNib(nibName: nibName)
            contentView?.frame = bounds
            contentView?.backgroundColor = .clear
            containerView.layer.cornerRadius = 12
            guard let content = contentView else {
                return
            }
            addSubview(content)
        }
    }
    
    private func loadNib(nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        guard let contentView: UIView = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {
            return UIView(frame: frame)
        }
        return contentView
    }
    
    func setupData(category: String) {
        contentLabel.text = category
    }
}
