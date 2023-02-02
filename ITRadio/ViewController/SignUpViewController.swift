//
//  SignUpViewController.swift
//  ITRadio
//
//  Created by zuzex-62 on 26.01.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var passwordView: UIView!
    @IBOutlet private weak var emailTxtField: UITextField!
    @IBOutlet private weak var emailLbl: UILabel!
    @IBOutlet private weak var passwordLbl: UILabel!
    @IBOutlet private weak var passwordTxtField: UITextField!
    @IBOutlet private weak var passwordHelperLbl: UILabel!
    @IBOutlet private weak var emailTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var passwordTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var showHidePasswordBtn: UIButton!
    @IBOutlet private weak var errorLbl: UILabel!
    
    private var isPasswordHide = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    @objc
    private func passwordViewTapped() {
        setNeededConstraints()
        passwordHelperLbl.numberOfLines = 1
        passwordTxtField.becomeFirstResponder()
        passwordTxtField.isHidden = false
        passwordTopConstraint.constant = 4
    }
    
    private func setNeededConstraints() {
        if let email = emailTxtField.text, email.count > 0 {
            emailTxtField.isHidden = false
            emailTopConstraint.constant = 2
        } else {
            emailTxtField.isHidden = true
            emailTopConstraint.constant = 25
        }
        if let password = passwordTxtField.text, password.count > 0 {
            passwordHelperLbl.numberOfLines = 1
            passwordTxtField.isHidden = false
            passwordTopConstraint.constant = 4
        } else {
            passwordHelperLbl.numberOfLines = 3
            passwordTxtField.isHidden = true
            passwordTopConstraint.constant = 3
        }
    }
    
    @IBAction
    private func signUpBtnClicked(_ sender: Any) {
        
    }
    
    @IBAction
    private func signInBtnClicked(_ sender: Any) {
        weak var pvc = presentingViewController
        dismiss(animated: false) {
            let vc = SignInViewController(nibName: "SignInViewController", bundle: nil)
            pvc?.present(vc, animated: true)
        }
    }
    @IBAction func showHidePasswordBtnClicked(_ sender: Any) {
        if isPasswordHide {
            passwordTxtField.isSecureTextEntry = false
            showHidePasswordBtn.setImage(UIImage(named: "eye_open"), for: .normal)
        } else {
            passwordTxtField.isSecureTextEntry = true
            showHidePasswordBtn.setImage(UIImage(named: "eye_close"), for: .normal)
        }
        isPasswordHide.toggle()
    }
    
    @objc
    private func dismissKeyboard() {
        setNeededConstraints()
        view.endEditing(true)
    }
    
}
