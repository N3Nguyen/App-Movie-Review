import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var iconPasswordButton: UIButton!
    @IBOutlet weak var iconConfirmButton: UIButton!
    @IBOutlet weak var notifiLabel: UILabel!
    
    private var isShowIconPassword: Bool = false
    private var isShowIconConfirmPassword: Bool = false
    var users: [Accounts] = []
    let yourAccount = AccountClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUITextFiled()
        accountTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
    }
    
    func setUpUITextFiled() {
        registerButton.isEnabled = false
        accountView.layer.cornerRadius = 10
        passwordView.layer.cornerRadius = 10
        confirmView.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 15
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        registerButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let titleChangeColor = NSMutableAttributedString(string: "Welcome to myMovie!")
        titleChangeColor.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 10))
        titleChangeColor.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 11, length: 7))
        titleLabel.attributedText = titleChangeColor
        let placeholderAccountText = NSAttributedString(string: "Enter username", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7237097025, green: 0.7098602057, blue: 0.7095651031, alpha: 1)])
        let placeholderPasswordText = NSAttributedString(string: "Enter password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7237097025, green: 0.7098602057, blue: 0.7095651031, alpha: 1)])
        let placeholderConfirmText = NSAttributedString(string: "Confirm password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7237097025, green: 0.7098602057, blue: 0.7095651031, alpha: 1)])
        
        accountTextField.attributedPlaceholder = placeholderAccountText
        passwordTextField.attributedPlaceholder = placeholderPasswordText
        confirmTextField.attributedPlaceholder = placeholderConfirmText
        passwordTextField.isSecureTextEntry = true
        confirmTextField.isSecureTextEntry = true
        
        accountTextField.addTarget(self, action: #selector(accountTextFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        confirmTextField.addTarget(self, action: #selector(confirmTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    func addNewUser(name: String, password: String) {
        yourAccount.loadAccountArray()
        users = yourAccount.accountArray
        
        if users.contains(where: { $0.accountName == name }) {
            notifiLabel.isHidden = false
            notifiLabel.text = "The account already exists, please enter another account."
        } else {
            let newUser = Accounts(accountName: name, accountPassword: password)
            users.append(newUser)
            yourAccount.saveAccountArray(account: users)
            notifiLabel.isHidden = false
            notifiLabel.text = "Account successfully created. Back to login."
        }
    }
    
    func showSuccessAlert() {
            let alertController = UIAlertController(title: "Account successfully created", message: "You have successfully registered a new account.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    
    @IBAction func didTapRegister(_ sender: UIButton) {
        if accountTextField.text != "" && passwordTextField.text != "" && confirmTextField.text != "" {
            if passwordTextField.text == confirmTextField.text {
                addNewUser(name: accountTextField.text!, password: passwordTextField.text!)
                showSuccessAlert()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let secondVC = sb.instantiateViewController(identifier: "loginID")
                    self.navigationController?.pushViewController(secondVC, animated: true)
                        }
            } else {
                notifiLabel.isHidden = false
                notifiLabel.text = "The two passwords do not match."
            }
        } else {
            notifiLabel.isHidden = false
            notifiLabel.text = "Account creation failed."
        }
        
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = sb.instantiateViewController(identifier: "loginID")
        self.navigationController?.pushViewController(secondVC, animated: false)
    }
    
    @IBAction func didTapLoginFacebook(_ sender: UIButton) {
    }
    
    @IBAction func didTapLoginApple(_ sender: UIButton) {
    }
    
    @IBAction func didTapShowPassword(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        iconPasswordButton.setImage(UIImage(named: passwordTextField.isSecureTextEntry ? "ic_eye_off" : "ic_eye"), for: .normal)
    }
    
    @IBAction func didTapShowConfirmPassword(_ sender: UIButton) {
        confirmTextField.isSecureTextEntry.toggle()
        iconConfirmButton.setImage(UIImage(named: confirmTextField.isSecureTextEntry ? "ic_eye_off" : "ic_eye"), for: .normal)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        checkButtonRegister(account: accountTextField, pass: passwordTextField, confi: confirmTextField)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case accountTextField:
            chageView(viewChange: accountView, viewDefault: passwordView, viewDefault2: confirmView)
        case passwordTextField:
            chageView(viewChange: passwordView, viewDefault: accountView, viewDefault2: confirmView)
        case confirmTextField:
            chageView(viewChange: confirmView, viewDefault: accountView, viewDefault2: passwordView)
        default:
            print("ấn vào thoat")
        }
    }
    
    func chageView(viewChange: UIView,viewDefault: UIView, viewDefault2: UIView) {
        viewChange.layer.shadowColor = #colorLiteral(red: 1, green: 0.5542021149, blue: 0.5003912457, alpha: 1)
        viewChange.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewChange.layer.shadowOpacity = 0.5
        viewChange.layer.shadowRadius = 5
        viewChange.layer.borderColor = #colorLiteral(red: 1, green: 0.01072909524, blue: 0, alpha: 1)
        viewChange.layer.borderWidth = 1
        
        viewDefault.layer.shadowOpacity = 0
        viewDefault.layer.borderColor = UIColor.clear.cgColor
        viewDefault.layer.borderWidth = 0
        
        viewDefault2.layer.shadowOpacity = 0
        viewDefault2.layer.borderColor = UIColor.clear.cgColor
        viewDefault2.layer.borderWidth = 0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case accountTextField:
            accountView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2666666667, blue: 0.2980392157, alpha: 1)
            checkTextField(textField: accountTextField)
        case passwordTextField:
            passwordView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2666666667, blue: 0.2980392157, alpha: 1)
            checkTextField(textField: passwordTextField)
        case confirmTextField:
            confirmView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2666666667, blue: 0.2980392157, alpha: 1)
            checkTextField(textField: confirmTextField)
        default:
            print("exit")
        }
        
        checkButtonRegister(account: accountTextField, pass: passwordTextField, confi: confirmTextField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.backgroundColor = #colorLiteral(red: 0.7497541966, green: 0.7941728231, blue: 0.9001023199, alpha: 1)
        return true
    }
    
    private func checkTextField(textField: UITextField) {
        notifiLabel.isHidden = !textField.text!.isEmpty
        if !textField.text!.isEmpty {
            notifiLabel.isHidden = true
            notifiLabel.text = "Please fill in all required fields."
        } else {
            notifiLabel.isHidden = false
        }
    }
}

extension RegisterViewController {
    @objc private func accountTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty || accountTextField.text?.isEmpty ?? true {
                checkButtonRegister(account: accountTextField, pass: passwordTextField, confi: confirmTextField)
            } else {
                checkButtonRegister(account: accountTextField, pass: passwordTextField, confi: confirmTextField)
            }
        }
    }
    
    @objc
    private func passwordTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty || passwordTextField.text?.isEmpty ?? true {
                checkButtonRegister(account: accountTextField, pass: passwordTextField, confi: confirmTextField)
            } else {
                checkButtonRegister(account: accountTextField, pass: passwordTextField, confi: confirmTextField)
            }
        }
    }
    
    @objc
    private func confirmTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty || confirmTextField.text?.isEmpty ?? true {
                checkButtonRegister(account: accountTextField, pass: passwordTextField, confi: confirmTextField)
            } else {
                checkButtonRegister(account: accountTextField, pass: passwordTextField, confi: confirmTextField)
            }
        }
    }
    private func checkButtonRegister(account: UITextField, pass: UITextField, confi: UITextField) {
        if !account.text!.isEmpty && !pass.text!.isEmpty && !confi.text!.isEmpty {
            registerButton.isEnabled = true
        } else {
            registerButton.isEnabled = false
        }
    }
}
