//
//  Tracks.swift
//  ITRadio
//
//  Created by zuzex-62 on 18.01.2023.
//

import Foundation
import UIKit

struct TrackResponse: Codable {
    var track: Tracks?
}

struct Tracks: Codable {
    var current: Track?
    var next: Track?
    var prevs: [Track]?
}

struct Track: Codable {
    var title: String
    var time: String
}

struct FavoriteTrack {
    var title: String
    var artist: String
    var image: UIImage
    var isLike: Bool
}

