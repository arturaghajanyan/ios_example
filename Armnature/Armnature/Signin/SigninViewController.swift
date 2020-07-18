//
//  SigninViewController.swift
//  Armnature
//
//  Created by Arthur on 5/26/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import FirebaseAuth
import FirebaseDatabase

class SigninViewController: UIViewController {

    enum RegexType: String {
            case password
            case email
            case text
    }
    var validation = Validation()

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var asGuestButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageForEmailField: UILabel!
    @IBOutlet weak var messageForPasswordField: UILabel!
    @IBOutlet weak var showPassword: UIButton!
    @IBOutlet weak var createAccauntButton: UIButton!
    
    var viewModel: SigninViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = !emailTextField.text!.isEmpty || !passwordTextField.text!.isEmpty
        if !loginButton.isEnabled {
            loginButton.backgroundColor = .gray
        }
        [emailTextField, passwordTextField].forEach({ $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged) })
        
        bindOutput()
        bindInput()
    }

    private func bindOutput() {
        viewModel.output.titleText
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
       
        viewModel.output.signInButtonText
            .drive(loginButton.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.output.showLoginPage
            .emit(onNext: { [unowned self] _ in
                self.clickOnLoginButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.output.showSignUpPage
            .emit(onNext: { [unowned self] _ in
                self.clickOnCreateAccauntButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.output.showForgotPasswordPage
            .emit(onNext: { [unowned self] _ in
                self.clickOnForgotPasswordButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.output.selectShowPasswordButton
            .emit(onNext: { [unowned self] _ in
                self.toggleShowPassword()
            })
            .disposed(by: disposeBag)
    }

    private func bindInput() {
        loginButton.rx.tap
            .bind(to: viewModel.input.selectLoginButton)
            .disposed(by: disposeBag)
        
        createAccauntButton.rx.tap
            .bind(to: viewModel.input.selectCreateAccauntButton)
            .disposed(by: disposeBag)
        
        forgotPasswordButton.rx.tap
            .bind(to: viewModel.input.selectForgotPasswordButton)
            .disposed(by: disposeBag)
        
        showPassword.rx.tap
            .bind(to: viewModel.input.selectShowPasswordButton)
            .disposed(by: disposeBag)
    }
    
    // Navigate Home page after click on login button
     func clickOnLoginButton() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(result, error) in
            if error == nil {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
                nextViewController.modalPresentationStyle = .fullScreen
                self.show(nextViewController, sender: nil)  
            } else {
                
            }
        }
    }
    
    // The function will work when they start to write something in the text field
    @objc func textFieldDidChange(_ textField: UITextField) {
        let isValidateName = validationTextField(textField: textField)
        if isValidateName == false {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.red.cgColor
            textField.textColor = .red
            styleForMessageField(textField: textField, textColor: .red, isValide: isValidateName)
        } else {
            textField.layer.borderColor = UIColor.blue.cgColor
            textField.textColor = .blue
            styleForMessageField(textField: textField, textColor: .blue, isValide: isValidateName)
        }
    }
    
    func validationTextField(textField: UITextField) -> Bool {
        switch textField {
        case self.emailTextField:
            return validateField(textField: textField, regex: RegexType.email.rawValue)
        case self.passwordTextField:
            return validateField(textField: textField, regex: RegexType.password.rawValue)
        default: break
        }
        return false
    }
    
    // Check the validity of text fields according to their regex validation
    func validateField(textField: UITextField, regex: String) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        self.verifyLoginButtonButtonIsEnabled()
        return self.validation.validate(textInInput: text, regex: regex)
    }
    
    // Enamble or disable signup button
    func verifyLoginButtonButtonIsEnabled() {
        loginButton.isEnabled = self.validation.validate(textInInput: emailTextField.text ?? "", regex: RegexType.email.rawValue) && self.validation.validate(textInInput: passwordTextField.text ?? "", regex: RegexType.password.rawValue)
        if loginButton.isEnabled {
            loginButton.backgroundColor = .blue
        } else {
            loginButton.backgroundColor = .gray
        }
    }

    // Show message on dependency textField
    func styleForMessageField(textField: UITextField, textColor: UIColor, isValide: Bool) {
        switch textField {
        case emailTextField:
            self.messageForEmailField.textColor = textColor
            isValide ? (self.messageForEmailField.text = "email") : (self.messageForEmailField.text = "Enter A Valid Email")
        case passwordTextField:
            self.messageForPasswordField.textColor = textColor
            isValide ? (self.messageForPasswordField.text = "password") : (self.messageForPasswordField.text = "Enter A Valid Password")
        default:
            break
        }
    }
    
    func toggleShowPassword() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        showPassword.isSelected = !passwordTextField.isSecureTextEntry
        let tmp = self.passwordTextField.text
        self.passwordTextField.text = " "
        self.passwordTextField.text = tmp
    }
    
    // Navigate Forgot Password page after click on forgot password button
    func clickOnForgotPasswordButton() {
            let storyBoard : UIStoryboard = UIStoryboard(name: "ForgotPassword", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
            nextViewController.viewModel = ForgotPasswordViewModel(data: SignDataBuilder.createForgotPasswordPageData())
            nextViewController.modalPresentationStyle = .fullScreen
            show(nextViewController, sender: nil)
        }
    
    func clickOnCreateAccauntButton() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Signup", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        nextViewController.viewModel = SignupViewModel(data: SignDataBuilder.createSignUpPageData())
        nextViewController.modalPresentationStyle = .fullScreen
        show(nextViewController, sender: nil)
    }
}

