//
//  StreamTableViewCell.swift
//  ITRadio
//
//  Created by zuzex-62 on 16.01.2023.
//

import UIKit
import RxSwift

protocol StreamCellProtocol {
    func songClicked(title: String, type: StreamType, isPlaying: Bool)
    func setPause(exceptType: StreamType)
}

class StreamTableViewCell: UITableViewCell {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var streamName: UILabel!
    @IBOutlet private weak var descriptionStreamLbl: UILabel!
    @IBOutlet private weak var currentSongNameLbl: UILabel!
    @IBOutlet private weak var playSongBtn: UIButton!
    @IBOutlet private weak var streamImageView: UIImageView!
    @IBOutlet private weak var currentSongStackView: UIStackView!
    
    private var isListening = false
    private var currentSong = "Unknown"
    private var streamType: StreamType = .rock
    var delegate: StreamCellProtocol?
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        currentSongStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(songClicked)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc
    private func songClicked() {
        delegate?.songClicked(title: currentSong, type: streamType, isPlaying: isListening)
    }
    
    func setViews(item: StreamModel) {
        streamType = item.name
        streamName.text = item.name.rawValue
        descriptionStreamLbl.text = item.description
        currentSongNameLbl.text = item.currentSong
        streamImageView.image = item.image
        isListening = item.isListening
        currentSong = item.currentSong
        stackView.backgroundColor = item.name.backgroundColor
        
        appContext.audioPlayer.state
            .subscribe(onNext: { value in
                switch value {
                case let .play(type: type):
                    print("curtype = \(type), streamtype = \(self.streamType)")
                    if type == self.streamType {
                        self.isListening = true
                        self.playSongBtn.setImage(UIImage(systemName: "pause.rectangle"), for: .normal)
                    } else {
                        self.isListening = false
                        self.playSongBtn.setImage(UIImage(systemName: "play.square"), for: .normal)
                    }
                case .stop:
                    self.playSongBtn.setImage(UIImage(systemName: "play.square"), for: .normal)
                case .connect:
                    self.playSongBtn.setImage(UIImage(systemName: "play.square"), for: .normal)
                }
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction
    private func playPauseBtnClicked(_ sender: Any) {
        if isListening {
            appContext.audioPlayer.stop()
        } else {
            appContext.audioPlayer.play(type: streamType)
            delegate?.setPause(exceptType: streamType)
            delegate?.songClicked(title: currentSong, type: streamType, isPlaying: !isListening)
        }
        isListening.toggle()
    }
    
}
