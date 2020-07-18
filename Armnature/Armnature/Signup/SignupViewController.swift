//
//  SignupViewController.swift
//  Armnature
//
//  Created by Arthur on 5/26/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignupViewController: UIViewController {
    
    enum RegexType: String {
            case password
            case email
            case text
    }
    var validation = Validation()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var messageForFirstNameField: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var messageForLastNameField: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var messageForCityField: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var messageForEmailField: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageForPasswordField: UILabel!
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var showPassword: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var viewModel: SignupViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.isEnabled = !firstNameTextField.text!.isEmpty || !lastNameTextField.text!.isEmpty || !cityTextField.text!.isEmpty || !emailTextField.text!.isEmpty || !passwordTextField.text!.isEmpty
        if !signUpButton.isEnabled {
            signUpButton.backgroundColor = .gray
        }
        [firstNameTextField, lastNameTextField, cityTextField, emailTextField, passwordTextField].forEach({ $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged) })
        
        bindOutput()
        bindInput()
    }
    
    private func bindOutput() {
        viewModel.output.titleText
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.signUpButtonText
            .drive(signUpButton.rx.title())
            .disposed(by: disposeBag)
         
         viewModel.output.selectSignUpButton
             .emit(onNext: { [unowned self] _ in
                 self.clickOnSignUpButton()
             })
             .disposed(by: disposeBag)
         
         viewModel.output.selectShowPasswordButton
             .emit(onNext: { [unowned self] _ in
                 self.toggleShowPassword()
             })
             .disposed(by: disposeBag)
         
         viewModel.output.showSignInPage
             .emit(onNext: { [unowned self] _ in
                 self.goToSignInPage()
             })
             .disposed(by: disposeBag)
    }
    
    private func bindInput() {
        signUpButton.rx.tap
            .bind(to: viewModel.input.selectSignUpButton)
            .disposed(by: disposeBag)
        
        showPassword.rx.tap
            .bind(to: viewModel.input.selectShowPasswordButton)
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .bind(to: viewModel.input.selectBackIcon)
            .disposed(by: disposeBag)
    }

    func clickOnSignUpButton() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){(result, error) in
            if error == nil {
                if let result = result {
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["firstName": self.firstNameTextField.text!, "lastName": self.lastNameTextField.text!, "city": self.cityTextField.text!, "email": self.emailTextField.text!])
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

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
        case self.firstNameTextField:
            return validateField(textField: textField, regex: RegexType.text.rawValue)
        case self.lastNameTextField:
            return validateField(textField: textField, regex: RegexType.text.rawValue)
        case self.cityTextField:
            return validateField(textField: textField, regex: RegexType.text.rawValue)
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
        self.verifySignUpButtonIsEnabled()
        return self.validation.validate(textInInput: text, regex: regex)
    }
    
    // Enamble or disable signup button
    func verifySignUpButtonIsEnabled() {
        signUpButton.isEnabled = self.validation.validate(textInInput: firstNameTextField.text ?? "", regex: RegexType.text.rawValue) && self.validation.validate(textInInput: lastNameTextField.text ?? "", regex: RegexType.text.rawValue) && self.validation.validate(textInInput: cityTextField.text ?? "", regex: RegexType.text.rawValue) && self.validation.validate(textInInput: emailTextField.text ?? "", regex: RegexType.email.rawValue) && self.validation.validate(textInInput: passwordTextField.text ?? "", regex: RegexType.password.rawValue)
        if signUpButton.isEnabled {
            signUpButton.backgroundColor = .blue
        } else {
            signUpButton.backgroundColor = .gray
        }
    }

    // Show message on dependency textField
    func styleForMessageField(textField: UITextField, textColor: UIColor, isValide: Bool) {
        switch textField {
        case firstNameTextField:
            self.messageForFirstNameField.textColor = textColor
            isValide ? (self.messageForFirstNameField.text = "name") : (self.messageForFirstNameField.text = "Valid length be [3-18] characters")
        case lastNameTextField:
            self.messageForLastNameField.textColor = textColor
            isValide ? (self.messageForLastNameField.text = "last name") : (self.messageForLastNameField.text = "Valid length be [3-18] characters")
        case cityTextField:
            self.messageForCityField.textColor = textColor
            isValide ? (self.messageForCityField.text = "city") : (self.messageForCityField.text = "Valid length be [3-18] characters")
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
    
    private func goToSignInPage() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Signin", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
        viewController.viewModel = SigninViewModel(data: SignDataBuilder.createSignInPageData())
        viewController.modalPresentationStyle = .fullScreen
        show(viewController, sender: nil)
    }
    
}
