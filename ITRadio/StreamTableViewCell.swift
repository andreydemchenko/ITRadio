//
//  StreamTableViewCell.swift
//  ITRadio
//
//  Created by zuzex-62 on 16.01.2023.
//

import UIKit

class StreamTableViewCell: UITableViewCell {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var streamName: UILabel!
    @IBOutlet private weak var descriptionStreamLbl: UILabel!
    @IBOutlet private weak var currentSongNameLbl: UILabel!
    @IBOutlet private weak var playSongBtn: UIButton!
    @IBOutlet private weak var streamImageView: UIImageView!
    @IBOutlet private weak var currentSongStackView: UIStackView!
    
    private var isListening = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setViews(item: StreamModel) {
        streamName.text = item.name.rawValue
        descriptionStreamLbl.text = item.description
        currentSongNameLbl.text = item.currentSong
        streamImageView.image = item.image
        isListening = item.isListening
        setPlayPauseImage()
        switch item.name {
        case .rock:
            stackView.backgroundColor = UIColor(red: 245/255, green: 220/255, blue: 61/255, alpha: 1)
        case .metalcore:
            stackView.backgroundColor = UIColor(red: 244/255, green: 98/255, blue: 49/255, alpha: 1)
        case .lite:
            stackView.backgroundColor = UIColor(red: 78/255, green: 159/255, blue: 218/255, alpha: 1)
        }
    }
    
    private func setPlayPauseImage() {
        if isListening {
            playSongBtn.setImage(UIImage(systemName: "pause.rectangle"), for: .normal)
        } else {
            playSongBtn.setImage(UIImage(systemName: "play.square"), for: .normal)
        }
    }
    
    @IBAction
    private func playPauseBtnClicked(_ sender: Any) {
        isListening.toggle()
        setPlayPauseImage()
    }
    
}
