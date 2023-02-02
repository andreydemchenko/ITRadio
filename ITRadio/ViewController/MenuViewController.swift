//
//  MenuViewController.swift
//  ITRadio
//
//  Created by zuzex-62 on 27.01.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet private weak var usernameLbl: UILabel!
    private var username = appContext.getUsername()

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLbl.text = username
    }

    @IBAction
    private func favoritesBtnClicked(_ sender: Any) {
        let vc = FavoritesViewController(nibName: "FavoritesViewController", bundle: nil)
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    @IBAction
    private func personalDataBtnClicked(_ sender: Any) {
        let vc = PersonalDataViewController(nibName: "PersonalDataViewController", bundle: nil)
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    @IBAction
    private func writeBtnClicked(_ sender: Any) {
        let vc = FeedbackViewController(nibName: "FeedbackViewController", bundle: nil)
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    @IBAction
    private func signOutBtnClicked(_ sender: Any) {
        let viewModel = appContext.authorizationViewModel
        viewModel.requestSignOut()
        dismiss(animated: true)
    }
    
}
