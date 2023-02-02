//
//  StreamModel.swift
//  ITRadio
//
//  Created by zuzex-62 on 16.01.2023.
//

import Foundation
import UIKit

enum StreamType: String {
    case rock = "Рок"
    case metalcore = "Металкор"
    case lite = "Лайт"
    
    var streamUrl: String {
        switch self {
        case .rock:
            return "https://it-radio.ru/rock"
        case .lite:
            return "https://it-radio.ru/lite"
        case .metalcore:
            return "https://it-radio.ru/mc"
        }
    }
    
    var streamTypeUrl: String {
        switch self {
        case .rock:
            return "rock"
        case .lite:
            return "lite"
        case .metalcore:
            return "mc"
        }
    }
    
    var streamNameEng: String {
        switch self {
        case .rock:
            return "Rock"
        case .lite:
            return "Lite"
        case .metalcore:
            return "Metalcore"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .rock:
            return UIColor(red: 245/255, green: 220/255, blue: 61/255, alpha: 1)
        case .lite:
            return UIColor(red: 78/255, green: 159/255, blue: 218/255, alpha: 1)
        case .metalcore:
            return UIColor(red: 244/255, green: 98/255, blue: 49/255, alpha: 1)
        }
    }
    
    var artistTextColor: UIColor {
        switch self {
        case .rock:
            return UIColor(red: 239/255, green: 52/255, blue: 73/255, alpha: 1)
        case .lite:
            return UIColor(red: 208/255, green: 20/255, blue: 245/255, alpha: 1)
        case .metalcore:
            return UIColor(red: 10/255, green: 62/255, blue: 164/255, alpha: 1)
        }
    }
    
    var maskImage: UIImage? {
        switch self {
        case .rock:
            return UIImage(named: "mask_rock")
        case .lite:
            return UIImage(named: "mask_lite")
        case .metalcore:
            return UIImage(named: "mask_metalcore")
        }
    }
    
}

struct StreamModel {
    var name: StreamType
    var description: String
    var currentSong: String
    var isListening: Bool
    var image: UIImage
}

struct CurrentSongsModel {
    var rock: String
    var metalcore: String
    var lite: String
    var streamPlaying: StreamType?
}
