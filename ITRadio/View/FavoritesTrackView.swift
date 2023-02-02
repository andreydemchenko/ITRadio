//
//  FavoritesTrackView.swift
//  ITRadio
//
//  Created by zuzex-62 on 30.01.2023.
//

import Foundation
import UIKit

protocol FavoritesTrackProtocol: AnyObject {
    func trackClicked(model: RatingsQuery.Data.Rating?)
}

class FavoritesTrackView: UIView {
   
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var trackNameLbl: UILabel!
    @IBOutlet private weak var artistNameLbl: UILabel!
    @IBOutlet private weak var likeDislikeBtn: UIButton!
    @IBOutlet private weak var infoBtn: UIButton!
    
    private var isFavorites = true
    private var model: RatingsQuery.Data.Rating?
    var delegate: FavoritesTrackProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setViews(model: RatingsQuery.Data.Rating?) {
        self.model = model
        trackNameLbl.text = model?.track?.title
        artistNameLbl.text = model?.track?.artist
        
        if let strUrl = model?.track?.cover?.small, let url = URL(string: strUrl) {
            url.getData { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.trackImageView.image = UIImage(data: data)
                }
            }
        }
//        if model.isLike {
//            isFavorites = true
//            likeDislikeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        } else {
//            isFavorites = false
//            likeDislikeBtn.setImage(UIImage(systemName: "bolt.heart.fill"), for: .normal)
//        }
    }
    
    @IBAction
    private func likeDislikeBtnClicked(_ sender: Any) {
        if isFavorites {
            
        } else {
            
        }
    }
    
    @IBAction
    private func infoBtnClicked(_ sender: Any) {
        delegate?.trackClicked(model: model)
    }
    
    
}
