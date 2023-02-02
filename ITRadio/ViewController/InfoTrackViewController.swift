//
//  InfoTrackViewController.swift
//  ITRadio
//
//  Created by zuzex-62 on 31.01.2023.
//

import UIKit

class InfoTrackViewController: UIViewController {
    
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var artistLbl: UILabel!
    @IBOutlet private weak var albumLbl: UILabel!
    @IBOutlet private weak var genreLbl: UILabel!
    @IBOutlet private weak var descriptionLbl: UILabel!
    @IBOutlet private weak var releaseLbl: UILabel!
    @IBOutlet private weak var yandexMscBtn: UIButton!
    @IBOutlet private weak var appleMscBtn: UIButton!
    @IBOutlet private weak var spotifyMscBtn: UIButton!
    
    var data: RatingsQuery.Data.Rating?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let track = data?.track {
            titleLbl.text = track.track
            artistLbl.text = track.artist
            albumLbl.text = track.album
            releaseLbl.text = track.release
            genreLbl.text = track.genre
            descriptionLbl.text = track.wikipedia
            
            if let strUrl = track.cover?.big, let url = URL(string: strUrl) {
                url.getData { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() { [weak self] in
                        self?.trackImageView.image = UIImage(data: data)
                    }
                }
            }
            if track.yandexMusic?.url == nil {
                yandexMscBtn.isHidden = true
            }
            if track.appleMusic?.url == nil {
                appleMscBtn.isHidden = true
            }
            if track.spotify?.url == nil {
                spotifyMscBtn.isHidden = true
            }
        }
    }

    @IBAction
    private func yandexMscBtnClicked(_ sender: Any) {
        if let strUrl = data?.track?.yandexMusic?.url, let url = URL(string: strUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction
    private func appleMscBtnClicked(_ sender: Any) {
        if let strUrl = data?.track?.appleMusic?.url, let url = URL(string: strUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction
    private func spotifyMscBtnClicked(_ sender: Any) {
        if let strUrl = data?.track?.spotify?.url, let url = URL(string: strUrl) {
            UIApplication.shared.open(url)
        }
    }
}
