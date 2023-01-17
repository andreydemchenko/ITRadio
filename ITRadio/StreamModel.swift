//
//  StreamModel.swift
//  ITRadio
//
//  Created by zuzex-62 on 16.01.2023.
//

import Foundation
import UIKit

enum StreamName: String {
    case rock = "Рок"
    case metalcore = "Металкор"
    case lite = "Лайт"
}

struct StreamModel {
    var name: StreamName
    var description: String
    var currentSong: String
    var isListening: Bool
    var image: UIImage
}
