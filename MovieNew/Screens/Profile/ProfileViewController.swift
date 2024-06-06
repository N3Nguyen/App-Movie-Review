import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func setUpTableView() {
        profileTableView.dataSource = self
        profileTableView.delegate = self
        let nibUser = UINib(nibName: "UserTableViewCell", bundle: nil)
        profileTableView.register(nibUser, forCellReuseIdentifier: "UserTableViewCell")
        let nibAcountUser = UINib(nibName: "AcountUserTableViewCell", bundle: nil)
        profileTableView.register(nibAcountUser, forCellReuseIdentifier: "AcountUserTableViewCell")
        let nibGeneral = UINib(nibName: "GeneralUserTableViewCell", bundle: nil)
        profileTableView.register(nibGeneral, forCellReuseIdentifier: "GeneralUserTableViewCell")
    }
    
    @IBAction func backHome(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func goPlaying(_ sender: UIButton) {
        let playingVC = storyboard?.instantiateViewController(withIdentifier: "PlayingScreen") as? PlayingMovieViewController
        self.navigationController?.pushViewController(playingVC!, animated: true)
        
    }
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = profileTableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else if indexPath.row == 1{
            guard let cell = profileTableView.dequeueReusableCell(withIdentifier: "AcountUserTableViewCell", for: indexPath) as? AcountUserTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = profileTableView.dequeueReusableCell(withIdentifier: "GeneralUserTableViewCell", for: indexPath) as? GeneralUserTableViewCell else {
                return UITableViewCell()
            }
            cell.delegateGeneral = self
            return cell
        }
    }
}

extension ProfileViewController: GeneralDelegate {
    func backLogin() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = sb.instantiateViewController(identifier: "loginID")
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
}

extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            animateTabBar(hidden: true)
        } else {
            animateTabBar(hidden: false)
        }
    }
}
