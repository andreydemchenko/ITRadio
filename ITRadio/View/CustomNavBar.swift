//
//  CustomNavBar.swift
//  ITRadio
//
//  Created by zuzex-62 on 19.01.2023.
//

import UIKit
import RxSwift
import RxCocoa

class CustomNavBar: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var navBarBtn: UIButton?
    
    private let disposeBag = DisposeBag()
    private var isLoggedIn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: CustomNavBar.self)
        bundle.loadNibNamed("CustomNavBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        navBarBtn?.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        navBarBtn?.titleLabel?.font = UIFont(name: "VelaSansGX-Medium", size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        var attributedStr = NSMutableAttributedString(string: "ВХОД И РЕГИСТРАЦИЯ", attributes: [NSAttributedString.Key.kern: 1, NSAttributedString.Key.paragraphStyle: paragraphStyle])

        let viewModel = appContext.authorizationViewModel
        
        if !appContext.getAuthorizationToken().isEmpty {
            isLoggedIn = true
            attributedStr = NSMutableAttributedString(string: "МЕНЮ", attributes: [NSAttributedString.Key.kern: 1, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }
        navBarBtn?.setAttributedTitle(attributedStr, for: .normal)
        
        viewModel.isUserLoggedIn
            .subscribe(onNext: { value in
                self.isLoggedIn = value
                self.setTitleNavBar()
            })
            .disposed(by: disposeBag)
    }
    
    private func setTitleNavBar() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        var attributedStr = NSMutableAttributedString(string: "ВХОД И РЕГИСТРАЦИЯ", attributes: [NSAttributedString.Key.kern: 1, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        if isLoggedIn {
            attributedStr = NSMutableAttributedString(string: "МЕНЮ", attributes: [NSAttributedString.Key.kern: 1, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }
        navBarBtn?.setAttributedTitle(attributedStr, for: .normal)
    }
    
    @IBAction
    private func navBarBtnClicked(_ sender: Any) {
        if isLoggedIn {
            let vc = MenuViewController(nibName: "MenuViewController", bundle: nil)
            UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true)
        } else {
            let vc = SignInViewController(nibName: "SignInViewController", bundle: nil)
            UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true)
        }
    }
}
