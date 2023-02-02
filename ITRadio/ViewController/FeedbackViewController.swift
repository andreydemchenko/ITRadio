//
//  FeedbackViewController.swift
//  ITRadio
//
//  Created by zuzex-62 on 01.02.2023.
//

import UIKit

class FeedbackViewController: UIViewController {

  
    @IBOutlet private weak var feedbackView: UIView!
    @IBOutlet private weak var textView: UITextView!
    
    private lazy var placeholderLbl: UILabel = {
        let label = UILabel()
        label.frame.origin = CGPoint(x: 5, y: 10)
        label.text = "Ваше предложение, отзыв или вопрос"
        label.textColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
    
    private weak var viewModel = appContext.homeViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        textView.addSubview(placeholderLbl)
        feedbackView.layer.borderWidth = 1
        feedbackView.layer.borderColor = UIColor.white.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @IBAction
    private func sendFeedbackBtnClicked(_ sender: Any) {
        if let text = textView.text {
            viewModel?.requestSendFeedback(text: text)
        }
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension FeedbackViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLbl.isHidden = !textView.text.isEmpty
    }

}
