import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var notifiLabel: UILabel!
    @IBOutlet weak var iconPasswordButton: UIButton!
    
    private var isShowIconPassword: Bool = true
    var users: [Accounts] = []
    let yourAccount = AccountClass()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUITextFiled()
        accountTextField.delegate = self
        passwordTextField.delegate = self
        let storedUsers = UserDefaults.standard.array(forKey: "usersKey") as? [[String: String]]
        
        let usernameToCheck = "nameUser"
        let passwordToCheck = "password"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        animateTabBar(hidden: true)
    }
    
    func setUpUITextFiled() {
        loginButton.isEnabled = false
        accountView.layer.cornerRadius = 10
        passwordView.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 15
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        loginButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let titleChangeColor = NSMutableAttributedString(string: "Welcome to myMovie!")
        titleChangeColor.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 10))
        titleChangeColor.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 11, length: 7))
        titleLabel.attributedText = titleChangeColor
        let placeholderAccountText = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7237097025, green: 0.7098602057, blue: 0.7095651031, alpha: 1)])
        let placeholderPasswordText = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7237097025, green: 0.7098602057, blue: 0.7095651031, alpha: 1)])
        
        accountTextField.attributedPlaceholder = placeholderAccountText
        passwordTextField.attributedPlaceholder = placeholderPasswordText
        passwordTextField.isSecureTextEntry = true
        accountTextField.addTarget(self, action: #selector(accountTextFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        if !accountTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            yourAccount.loadAccountArray()
            users = yourAccount.accountArray
            let statusAccount = accountTextField.text
            let isValidAcc = users.contains { $0.accountName == accountTextField.text && $0.accountPassword == passwordTextField.text }
            if isValidAcc {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let secondVC = sb.instantiateViewController(identifier: "tabbarID")
                self.navigationController?.pushViewController(secondVC, animated: false)
                
                userDefaults.set(statusAccount, forKey: "statusAcc")
                userDefaults.set(true, forKey: "isLoggedIn")
            } else {
                notifiLabel.isHidden = false
                notifiLabel.text = "Invalid username or password. Please try again."
            }
        }
    }
    
    @IBAction func didTapRegister(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = sb.instantiateViewController(identifier: "registerID")
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @IBAction func didTapLoginFacebook(_ sender: UIButton) {
    }
    
    @IBAction func didTapLoginApple(_ sender: UIButton) {
    }
    
    @IBAction func didTapShowPassword(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        iconPasswordButton.setImage(UIImage(named: passwordTextField.isSecureTextEntry ? "ic_eye_off" : "ic_eye"), for: .normal)
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        checkButtonRegister(account: accountTextField, pass: passwordTextField)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case accountTextField:
            chageView(viewChange: accountView, viewDefault: passwordView)
        case passwordTextField:
            chageView(viewChange: passwordView, viewDefault: accountView)
        default:
            print("exit")
        }
    }
    
    func chageView(viewChange: UIView,viewDefault: UIView) {
        viewChange.layer.shadowColor = #colorLiteral(red: 1, green: 0.5542021149, blue: 0.5003912457, alpha: 1)
        viewChange.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewChange.layer.shadowOpacity = 0.5
        viewChange.layer.shadowRadius = 5
        viewChange.layer.borderColor = #colorLiteral(red: 1, green: 0.01072909524, blue: 0, alpha: 1)
        viewChange.layer.borderWidth = 1
        
        viewDefault.layer.shadowOpacity = 0
        viewDefault.layer.borderColor = UIColor.clear.cgColor
        viewDefault.layer.borderWidth = 0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case accountTextField:
            accountView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2666666667, blue: 0.2980392157, alpha: 1)
        case passwordTextField:
            passwordView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2666666667, blue: 0.2980392157, alpha: 1)
        default:
            print("exit")
        }
        
        checkButtonRegister(account: accountTextField, pass: passwordTextField)
    }
    
    func checkTextField(textField: UITextField) {
        notifiLabel.isHidden = !textField.text!.isEmpty
        if !textField.text!.isEmpty {
            notifiLabel.isHidden = true
            notifiLabel.text = "Invalid username or password. Please try again."
        } else {
            notifiLabel.isHidden = false
        }
    }
}

extension LoginViewController {
    @objc
    private func accountTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty || accountTextField.text?.isEmpty ?? true {
                checkButtonRegister(account: accountTextField, pass: passwordTextField)
            } else {
                checkButtonRegister(account: accountTextField, pass: passwordTextField)
            }
        }
    }
    
    @objc
    private func passwordTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty || passwordTextField.text?.isEmpty ?? true {
                checkButtonRegister(account: accountTextField, pass: passwordTextField)
            } else {
                checkButtonRegister(account: accountTextField, pass: passwordTextField)
            }
        }
    }
    
    private func checkButtonRegister(account: UITextField, pass: UITextField) {
        if !account.text!.isEmpty && !pass.text!.isEmpty {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
}
