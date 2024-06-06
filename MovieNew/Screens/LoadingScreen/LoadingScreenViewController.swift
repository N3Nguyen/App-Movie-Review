import UIKit

class LoadingScreenViewController: UIViewController {
    
    @IBOutlet var loadingView: UIView!
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        animationView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.checkLoginState()
        }
    }
    
    func setUpView() {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: loadingView.frame.width, height: loadingView.frame.height))
        gradientView.center = loadingView.center
        loadingView.addSubview(gradientView)
        
        let imageView = UIImageView(frame: gradientView.bounds)
        imageView.contentMode = .center
        imageView.image = UIImage(named: "ic_Logo")
        gradientView.addSubview(imageView)
    }
    
    func animationView() {
        loadingView.transform = CGAffineTransform(translationX: loadingView.frame.width, y: 0)
        
        UIView.animate(withDuration: 1, animations: {
            self.loadingView.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    func checkLoginState() {
        if userDefaults.bool(forKey: "isLoggedIn") {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = sb.instantiateViewController(identifier: "tabbarID")
            self.navigationController?.pushViewController(secondVC, animated: true)
            userDefaults.set(true, forKey: "isChangingMenu")
        } else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = sb.instantiateViewController(identifier: "loginID")
            self.navigationController?.pushViewController(loginVC, animated: true)
            userDefaults.set(false, forKey: "isChangingMenu")
        }
    }
}
