//
//  CurrentStreamItemView.swift
//  ITRadio
//
//  Created by zuzex-62 on 20.01.2023.
//

import UIKit

class CurrentStreamItemView: UIView {

    @IBOutlet private weak var timeLbl: UILabel?
    @IBOutlet private weak var titleLbl: UILabel?
    
    func setViews(time: String, title: String, isCurrentStream: Bool) {
        timeLbl?.text = time
        titleLbl?.text = title
        if isCurrentStream {
            titleLbl?.textColor = .white
        } else {
            titleLbl?.textColor = .lightGray
        }
    }
    
}
