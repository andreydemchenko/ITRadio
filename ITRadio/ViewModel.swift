//
//  ViewModel.swift
//  ITRadio
//
//  Created by zuzex-62 on 16.01.2023.
//

import Foundation
import UIKit

protocol ViewModelDelegate: AnyObject {
    func reloadStreams(source: [StreamModel])
    func currentSongDidChage(name: String)
}

class ViewModel {

    private var labelText: String {
        didSet {
            delegate?.currentSongDidChage(name: labelText)
        }
    }
    
    private var dataSource: [StreamModel] {
        didSet {
            delegate?.reloadStreams(source: dataSource)
        }
    }

    weak var delegate: ViewModelDelegate? {
        didSet {
            delegate?.currentSongDidChage(name: labelText)
        }
    }

    init() {
        dataSource = []
        labelText = "Simple Dimple"
    }
}
