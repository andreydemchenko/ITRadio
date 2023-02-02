//
//  PersonalDataViewController.swift
//  ITRadio
//
//  Created by zuzex-62 on 31.01.2023.
//

import UIKit

class PersonalDataViewController: UIViewController {
    
    @IBOutlet private weak var nicknameView: UIView!
    @IBOutlet private weak var birthdateView: UIView!
    @IBOutlet private weak var nicknameTxtField: UITextField!
    @IBOutlet private weak var birthdateTxtField: UITextField!
    @IBOutlet private weak var nogenderView: UIView!
    @IBOutlet private weak var maleView: UIView!
    @IBOutlet private weak var femaleView: UIView!
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()
    
    private let lightRedColor = UIColor(red: 215/255, green: 91/255, blue: 60/255, alpha: 1)
    private let darkGrayColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let username = appContext.getUsername()
        if username != "username" {
            nicknameTxtField.text = username
        }

        nicknameTxtField.borderStyle = .none
        birthdateTxtField.borderStyle = .none
        nicknameView.layer.borderWidth = 1
        nicknameView.layer.borderColor = UIColor.white.cgColor
        birthdateView.layer.borderWidth = 1
        birthdateView.layer.borderColor = UIColor.white.cgColor
        nogenderView.layer.borderWidth = 1
        nogenderView.layer.borderColor = UIColor.white.cgColor
        maleView.layer.borderWidth = 1
        maleView.layer.borderColor = UIColor.white.cgColor
        femaleView.layer.borderWidth = 1
        femaleView.layer.borderColor = UIColor.white.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        let nogenderTap = UITapGestureRecognizer(target: self, action: #selector(nogenderViewTapped))
        let maleTap = UITapGestureRecognizer(target: self, action: #selector(maleViewTapped))
        let femaleTap = UITapGestureRecognizer(target: self, action: #selector(femaleViewTapped))
        view.addGestureRecognizer(tap)
        nogenderView.addGestureRecognizer(nogenderTap)
        maleView.addGestureRecognizer(maleTap)
        femaleView.addGestureRecognizer(femaleTap)
        
        birthdateTxtField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    @objc
    private func handleDatePicker(sender: UIDatePicker) {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd MMM yyyy"
          birthdateTxtField.text = dateFormatter.string(from: sender.date)
     }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func nogenderViewTapped() {
        nogenderView.backgroundColor = lightRedColor
        maleView.backgroundColor = darkGrayColor
        femaleView.backgroundColor = darkGrayColor
    }
    
    @objc
    private func maleViewTapped() {
        nogenderView.backgroundColor = darkGrayColor
        maleView.backgroundColor = lightRedColor
        femaleView.backgroundColor = darkGrayColor
    }
    
    @objc
    private func femaleViewTapped() {
        nogenderView.backgroundColor = darkGrayColor
        maleView.backgroundColor = darkGrayColor
        femaleView.backgroundColor = lightRedColor
    }
    
    @IBAction
    private func saveChangesBtnClicked(_ sender: Any) {
        
    }
    
    @IBAction
    private func changeEmailBtnClicked(_ sender: Any) {
        
    }
    
    @IBAction
    private func changePasswordBtnClicked(_ sender: Any) {
        
    }
    
}
