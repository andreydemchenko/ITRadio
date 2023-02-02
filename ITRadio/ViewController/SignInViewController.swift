//
//  SignInViewController.swift
//  ITRadio
//
//  Created by zuzex-62 on 26.01.2023.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet private weak var signInLbl: UILabel!
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var passwordView: UIView!
    @IBOutlet private weak var emailTxtField: UITextField!
    @IBOutlet private weak var passwordTxtField: UITextField!
    @IBOutlet private weak var emailLbl: UILabel!
    @IBOutlet private weak var passwordLbl: UILabel!
    @IBOutlet private weak var emailTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var emailBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var passwordTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var passwordBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var securePasswordBtn: UIButton!
    
    private var isPasswordHide = true
    private let viewModel = appContext.authorizationViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        signInLbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
//        signInLbl.font = UIFont(name: "Inter-Black", size: 28)
        emailLbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        emailLbl.font =  UIFont(name: "VelaSansGX-Regular", size: 16)
        passwordLbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        passwordLbl.font = UIFont(name: "VelaSansGX-Regular", size: 16)

        emailView.layer.borderWidth = 1
        emailView.layer.borderColor = UIColor.white.cgColor
        passwordView.layer.borderWidth = 1
        passwordView.layer.borderColor = UIColor.white.cgColor
        
        emailTxtField.borderStyle = .none
        passwordTxtField.borderStyle = .none
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        let emailTap = UITapGestureRecognizer(target: self, action: #selector(emailViewTapped))
        let passTap = UITapGestureRecognizer(target: self, action: #selector(passwordViewTapped))
        view.addGestureRecognizer(tap)    
        emailView.addGestureRecognizer(emailTap)
        passwordView.addGestureRecognizer(passTap)
    }
                                             
    @objc
    private func emailViewTapped() {
        setNeededConstraints()
        emailTxtField.becomeFirstResponder()
        emailTxtField.isHidden = false
        emailTopConstraint.constant = 4
        emailBottomConstraint.constant = 50
    }
    
    @objc
    private func passwordViewTapped() {
        setNeededConstraints()
        passwordTxtField.becomeFirstResponder()
        passwordTxtField.isHidden = false
        passwordTopConstraint.constant = 4
        passwordBottomConstraint.constant = 50
    }
    
    @IBAction
    private func forgetPasswordBtnClicked(_ sender: Any) {
        setNeededConstraints()
    }
    
    @IBAction
    private func signInBtnClicked(_ sender: Any) {
        setNeededConstraints()
        if let email = emailTxtField.text, email.count > 0,
           let password = passwordTxtField.text, password.count > 0 {
            viewModel.requestSignIn(email: email, password: password)
            dismiss(animated: true)
        }
    }
    
    @IBAction
    private func signUpBtnClicked(_ sender: Any) {
        setNeededConstraints()
        weak var pvc = presentingViewController
        dismiss(animated: false) {
            let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
            pvc?.present(vc, animated: true)
        }
    }
    
    @objc
    private func dismissKeyboard() {
        setNeededConstraints()
        view.endEditing(true)
    }
    
    private func setNeededConstraints() {
        if let email = emailTxtField.text, email.count > 0 {
            emailTxtField.isHidden = false
            emailTopConstraint.constant = 4
            emailBottomConstraint.constant = 50
        } else {
            emailTxtField.isHidden = true
            emailTopConstraint.constant = 27
            emailBottomConstraint.constant = 27
        }
        if let password = passwordTxtField.text, password.count > 0 {
            passwordTxtField.isHidden = false
            passwordTopConstraint.constant = 4
            passwordBottomConstraint.constant = 50
        } else {
            passwordTxtField.isHidden = true
            passwordTopConstraint.constant = 27
            passwordBottomConstraint.constant = 27
        }
    }
    
    @IBAction
    private func showHidePasswordBtnClicked(_ sender: Any) {
        if isPasswordHide {
            passwordTxtField.isSecureTextEntry = false
            securePasswordBtn.setImage(UIImage(named: "eye_open"), for: .normal)
        } else {
            passwordTxtField.isSecureTextEntry = true
            securePasswordBtn.setImage(UIImage(named: "eye_close"), for: .normal)
        }
        isPasswordHide.toggle()
    }
}
