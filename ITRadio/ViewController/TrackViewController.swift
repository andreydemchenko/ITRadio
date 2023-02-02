//
//  TrackViewController.swift
//  ITRadio
//
//  Created by zuzex-62 on 18.01.2023.
//

import UIKit
import RxSwift

class TrackViewController: UIViewController {

    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var playPauseView: UIView!
    @IBOutlet private weak var streamNameLbl: UILabel!
    @IBOutlet private weak var imgePlaceView: UIView!
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var artistNameLbl: UILabel!
    @IBOutlet private weak var currentStreamStackView: UIStackView!
    @IBOutlet private weak var downStreamListBtn: UIButton!
    @IBOutlet private weak var dislikeBtn: UIButton!
    @IBOutlet private weak var likeBtn: UIButton!
    
    private var animView: AnimLoadingTrackView?
    
    private var isStreamListShown = false
    private let maskView = UIImageView()
    
    private lazy var lightningImage1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "lightning1")
        let x1 = trackImageView.frame.minX
        let y1 = trackImageView.frame.maxY
        image.frame = CGRect(origin: CGPoint(x: x1 - 15, y: y1 - 40), size: CGSize(width: 26, height: 60))
        //image.center = CGPoint(x: x1, y: y1) //CGRect(x: x1 + 26, y: y1 + 4, width: 26, height: 60)
        return image
    }()
    
    private lazy var lightningImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "lightning2")
        let x1 = trackImageView.frame.maxX
        let y1 = trackImageView.frame.minY
        image.frame = CGRect(x: x1 - 50, y: y1 - 3, width: 25, height: 40)
        return image
    }()
    
    private lazy var lightningImage3: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "lightning3")
        let x1 = trackImageView.frame.maxX
        let y1 = trackImageView.frame.minY
        image.frame = CGRect(origin: CGPoint(x: x1 - 18, y: y1 + 5), size: CGSize(width: 24, height: 37))
        return image
    }()
    
    private lazy var fireImage1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "fire1")
        let x1 = trackImageView.frame.minX
        let y1 = trackImageView.frame.maxY
        image.frame = CGRect(x: x1 - 35, y: y1 - 25, width: 60, height: 68)
        return image
    }()
    
    private lazy var fireImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "fire2")
        let x1 = trackImageView.frame.maxX
        let y1 = trackImageView.frame.minY
        image.frame = CGRect(x: x1 - 70, y: y1 - 20, width: 50, height: 50)
        return image
    }()
    
    private lazy var fireImage3: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "fire3")
        let x1 = trackImageView.frame.maxX
        let y1 = trackImageView.frame.minY
        image.frame = CGRect(x: x1 - 35, y: y1 - 20, width: 60, height: 60)
        return image
    }()
    
    private lazy var cloudImage1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cloud1")
        let x1 = trackImageView.frame.minX
        let y1 = trackImageView.frame.maxY
        image.frame = CGRect(x: x1 - 30, y: y1 - 40, width: 60, height: 60)
        return image
    }()
    
    private lazy var cloudImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cloud2")
        let x1 = trackImageView.frame.maxX
        let y1 = trackImageView.frame.minY
        image.frame = CGRect(x: x1 - 80, y: y1 - 15, width: 60, height: 60)
        return image
    }()
    
    private lazy var cloudImage3: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cloud3")
        let x1 = trackImageView.frame.maxX
        let y1 = trackImageView.frame.minY
        image.frame = CGRect(x: x1 - 30, y: y1 - 15, width: 60, height: 60)
        return image
    }()
    
    var songTitle = "Unknown"
    var type: StreamType = .rock
    var isPlaying = false
    
    private weak var homeViewModel: HomeViewModel?
    private var trackID: String?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //appContext.audioPlayer.delegate = self
        
        homeViewModel = appContext.homeViewModel
        getData()
        setViews()
        setSubscribers()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(swipeRight)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
        view.addGestureRecognizer(tap)

        playPauseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playPauseViewClicked)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    private func getData() {
        homeViewModel?.requestSongDetails(songTitle: songTitle)
    }
    
    private func setViews() {
        animView = Bundle.main.loadNibNamed("AnimLoadingTrackView", owner: self, options: nil)?.first as? AnimLoadingTrackView
        if let animView {
            animView.setViews(state: .stop)
            playPauseView.addSubview(animView)
        }
        titleLbl.text = songTitle
        titleLbl.font = UIFont(name: "VelaSansGX-ExtraBold", size: 25)
        artistNameLbl.font = UIFont(name: "VelaSansGX-ExtraBold", size: 19)
        streamNameLbl.text = type.streamNameEng
        titleLbl.backgroundColor = type.backgroundColor
        let backgroundColor = type.backgroundColor
        currentStreamStackView.backgroundColor = backgroundColor
        downStreamListBtn.backgroundColor = backgroundColor
        artistNameLbl.backgroundColor = backgroundColor
        artistNameLbl.textColor = type.artistTextColor
        trackImageView.tag = 110
    }
    
    private func setSubscribers() {
        homeViewModel?.trackDetails
            .subscribe(onNext: { trackDetails in
                self.trackID = trackDetails._id
                self.titleLbl.text = trackDetails.title
                self.artistNameLbl.text = trackDetails.artist
                if let strUrl = trackDetails.cover?.big, let url = URL(string: strUrl) {
                    self.downloadImage(from: url)
                }
            })
            .disposed(by: disposeBag)
        
        appContext.audioPlayer.currentTrack
            .subscribe(onNext: { track in
                self.titleLbl.text = track.title
                self.artistNameLbl.text = track.artist
                if let strUrl = track.cover?.big, let url = URL(string: strUrl) {
                    self.downloadImage(from: url)
                }
            })
            .disposed(by: disposeBag)
        
        appContext.audioPlayer.state
            .subscribe(onNext: { value in
                if let animView = self.animView {
                    animView.setViews(state: value)
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        maskView.contentMode = trackImageView.contentMode
        maskView.frame = trackImageView.bounds
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc
    private func rotated() {
        maskView.frame = trackImageView.bounds
    }
    
    @objc
    private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if gesture.location(in: view).x < 10 {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.right:
                    navigationController?.popViewController(animated: true)
                    
                default: break
                }
            }
        }
    }
    
    private func downloadImage(from url: URL) {
        url.getData { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.trackImageView.image = UIImage(data: data)
                self?.maskView.image = self?.type.maskImage
                self?.trackImageView.mask = self?.maskView
                self?.setAdditionalImages()
            }
        }
    }
    
    private func setAdditionalImages() {
        imgePlaceView.subviews.forEach {
            if $0 != $0.viewWithTag(110) {
                $0.removeFromSuperview()
            }
        }
        switch type {
        case .rock:
            imgePlaceView.addSubview(lightningImage1)
            imgePlaceView.addSubview(lightningImage2)
            imgePlaceView.addSubview(lightningImage3)
        case .metalcore:
            imgePlaceView.addSubview(fireImage1)
            imgePlaceView.addSubview(fireImage2)
            imgePlaceView.addSubview(fireImage3)
        case .lite:
            imgePlaceView.addSubview(cloudImage1)
            imgePlaceView.addSubview(cloudImage2)
            imgePlaceView.addSubview(cloudImage3)
        }
    }

    @objc
    private func playPauseViewClicked() {
        if isPlaying {
            appContext.audioPlayer.stop()
        } else {
            appContext.audioPlayer.play(type: type)
        }
        isPlaying.toggle()
        //setPlayPauseImage()
    }
    
    @IBAction
    private func downStreamListClicked(_ sender: Any) {
        let vc = CurrentTracksViewController(nibName: "CurrentTracksViewController", bundle: nil)
        vc.currentStream = type
        vc.delegate = self
        present(vc, animated: true)
        
        isStreamListShown.toggle()
    }
    
    @objc
    private func dismissViews() {
        if let viewWithTag = self.view.viewWithTag(101) {
            UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
              viewWithTag.removeFromSuperview()
            }, completion: nil)
        }
        if let viewWithTag = self.view.viewWithTag(102) {
            UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
              viewWithTag.removeFromSuperview()
            }, completion: nil)
        }
    }
                                             
    @objc
    private func didTapOnStreamListItemView(sender: UITapGestureRecognizer) {
        if sender.view?.tag == 101 {
            switch type {
            case .rock:
                switchToStream(to: .metalcore)
            case .metalcore:
                switchToStream(to: .rock)
            case .lite:
                switchToStream(to: .rock)
            }
        } else if sender.view?.tag == 102 {
            switch type {
            case .rock:
                switchToStream(to: .lite)
            case .metalcore:
                switchToStream(to: .lite)
            case .lite:
                switchToStream(to: .metalcore)
            }
        }
    }
    
    private func switchToStream(to type: StreamType) {
        let vc = TrackViewController(nibName: "TrackViewController", bundle: nil)
        vc.type = type
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction
    private func dislikeBtnClicked(_ sender: Any) {
        if let trackID {
            homeViewModel?.requestRateTrack(id: trackID, type: .dislike)
        }
    }
    
    @IBAction
    private func likeBtnClicked(_ sender: Any) {
        if let trackID {
            homeViewModel?.requestRateTrack(id: trackID, type: .like)
        }
    }
    
}

extension TrackViewController: CurrentTrackProtocol {
    
    func streamChanged(type: StreamType, songName: String) {
        songTitle = songName
        self.type = type
        getData()
        setViews()
        isPlaying = false
        playPauseViewClicked()
    }
    
}

extension TrackViewController: AudioPlayerProtocol {
    
    func stateChanged(state: PlayerState) {
        if let animView {
            animView.setViews(state: state)
        }
    }
    
}
