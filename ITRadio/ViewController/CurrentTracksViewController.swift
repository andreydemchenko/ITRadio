//
//  CurrentTracksViewController.swift
//  ITRadio
//
//  Created by zuzex-62 on 20.01.2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol CurrentTrackProtocol: AnyObject {
    func streamChanged(type: StreamType, songName: String)
}

class CurrentTracksViewController: UIViewController {

    @IBOutlet private weak var rockStackView: UIStackView!
    @IBOutlet private weak var rockElementsStackView: UIStackView!
    @IBOutlet private weak var metalcoreStackView: UIStackView!
    @IBOutlet private weak var metalcoreElementsStackView: UIStackView!
    @IBOutlet private weak var liteStackView: UIStackView!
    @IBOutlet private weak var liteElementsStackView: UIStackView!
    @IBOutlet private weak var rockImageView: UIImageView!
    @IBOutlet private weak var rockLbl: UILabel!
    @IBOutlet private weak var metalcoreImageView: UIImageView!
    @IBOutlet private weak var metalcoreLbl: UILabel!
    @IBOutlet private weak var liteImageView: UIImageView!
    @IBOutlet private weak var liteLbl: UILabel!
    
    private var rockTracks = Tracks()
    private var metalTracks = Tracks()
    private var liteTracks = Tracks()
    
    private weak var homeViewModel: HomeViewModel?
    
    var currentStream: StreamType = .rock
    var delegate: CurrentTrackProtocol?
    private let disposeBag = DisposeBag()
    private var currentSongRock: String?
    private var currentSongMetal: String?
    private var currentSongLite: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewModel = appContext.homeViewModel
        homeViewModel?.requestData()

        addActions()
        getData()
    }

    private func getData() {
        switch currentStream {
        case .rock:
            setRockView()
        case .metalcore:
            setMetalView()
        case .lite:
            setLiteView()
        }
        
        /*let group = DispatchGroup()
        group.enter()
        appContext.networkManager.getTracks(type: .rock) { [weak self] result in
            switch result {
            case .success(let data):
                if let tracks = data.track {
                    self?.rockTracks = tracks
                }
                case .failure(let error):
                print("Error occurred with getting rock tracks: \(error.localizedDescription)")
            }
            group.leave()
        }
        group.enter()
        appContext.networkManager.getTracks(type: .metalcore) { [weak self] result in
            switch result {
            case .success(let data):
                if let tracks = data.track {
                    self?.metalTracks = tracks
                }
            case .failure(let error):
                print("Error occurred with getting metalcore tracks: \(error.localizedDescription)")
            }
            group.leave()
        }
        group.enter()
        appContext.networkManager.getTracks(type: .lite) { [weak self] result in
            switch result {
            case .success(let data):
                if let tracks = data.track {
                    self?.liteTracks = tracks
                }
            case .failure(let error):
                print("Error occurred with getting lite tracks: \(error.localizedDescription)")
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.setSongsViews()
        }*/
        homeViewModel?.rockTracks
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { value in
                if let title = value.track?.current?.title  {
                    self.currentSongRock = title
                    self.setCurrentSongsViews(streamType: .rock, title: title)
                }
                if let data = value.track {
                    self.rockTracks = data
                    self.setSongsViews()
                }
            })
            .disposed(by: disposeBag)
        homeViewModel?.metalcoreTracks
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { value in
                if let title = value.track?.current?.title  {
                    self.currentSongMetal = title
                    self.setCurrentSongsViews(streamType: .metalcore, title: title)
                }
                if let data = value.track {
                    self.metalTracks = data
                    self.setSongsViews()
                }
            })
            .disposed(by: disposeBag)
        homeViewModel?.liteTracks
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { value in
                if let title = value.track?.current?.title {
                    self.currentSongLite = title
                    self.setCurrentSongsViews(streamType: .lite, title: title)
                }
                if let data = value.track {
                    self.liteTracks = data
                    self.setSongsViews()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setCurrentSongsViews(streamType: StreamType, title: String) {
        var isCurrentStream = false
        if streamType == currentStream {
            isCurrentStream = true
        }
        switch streamType {
        case .rock:
            rockElementsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            setView(time: "Сейчас", title: title, isCurrentStream: isCurrentStream, stackView: rockElementsStackView)
        case .metalcore:
            metalcoreElementsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            setView(time: "Сейчас", title: title, isCurrentStream: isCurrentStream, stackView: metalcoreElementsStackView)
        case .lite:
            liteElementsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            setView(time: "Сейчас", title: title, isCurrentStream: isCurrentStream, stackView: liteElementsStackView)
        }
    }
    
    private func setView(time: String, title: String, isCurrentStream: Bool, stackView: UIStackView) {
        if let item = Bundle.main.loadNibNamed("CurrentStreamItemView", owner: self, options: nil)?.first as? CurrentStreamItemView {
            item.setViews(time: time, title: title, isCurrentStream: isCurrentStream)
            stackView.addArrangedSubview(item)
        }
    }
    
    private func setSongsViews() {
        switch currentStream {
        case .rock:
            rockElementsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            if let title = rockTracks.next?.title {
                setView(time: "Дальше", title: title, isCurrentStream: true, stackView: rockElementsStackView)
            }
            if let title = rockTracks.current?.title {
                setView(time: "Сейчас", title: title, isCurrentStream: true, stackView: rockElementsStackView)
            }
            rockTracks.prevs?.forEach {
                if let title = rockTracks.current?.title {
                    setView(time: $0.time, title: title, isCurrentStream: true, stackView: rockElementsStackView)
                }
            }
        case .metalcore:
            metalcoreElementsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            if let title = metalTracks.next?.title {
                setView(time: "Дальше", title: title, isCurrentStream: true, stackView: metalcoreElementsStackView)
            }
            if let title = metalTracks.current?.title {
                setView(time: "Сейчас", title: title, isCurrentStream: true, stackView: metalcoreElementsStackView)
            }
            metalTracks.prevs?.forEach {
                if let title = metalTracks.current?.title {
                    setView(time: $0.time, title: title, isCurrentStream: true, stackView: metalcoreElementsStackView)
                }
            }
        case .lite:
            liteElementsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            if let title = liteTracks.next?.title {
                setView(time: "Дальше", title: title, isCurrentStream: true, stackView: liteElementsStackView)
            }
            if let title = liteTracks.current?.title {
                setView(time: "Сейчас", title: title, isCurrentStream: true, stackView: liteElementsStackView)
            }
            liteTracks.prevs?.forEach {
                if let title = liteTracks.current?.title {
                    setView(time: $0.time, title: title, isCurrentStream: true, stackView: liteElementsStackView)
                }
            }
        }
    }
    
    private func addActions() {
        rockStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rockStackViewClicked)))
        metalcoreStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(metalcoreStackViewClicked)))
        liteStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(liteStackViewClicked)))
    }
    
    private func setRockView() {
        rockImageView.image = UIImage(named: "rock_arrow")
        metalcoreImageView.image = UIImage(named: "empty_arrow")
        liteImageView.image = UIImage(named: "empty_arrow")
        
        rockLbl.textColor = StreamType.rock.backgroundColor
        metalcoreLbl.textColor = .lightGray
        liteLbl.textColor = .lightGray
    }
    
    private func setMetalView() {
        rockImageView.image = UIImage(named: "empty_arrow")
        metalcoreImageView.image = UIImage(named: "metalcore_arrow")
        liteImageView.image = UIImage(named: "empty_arrow")
        
        rockLbl.textColor = .lightGray
        metalcoreLbl.textColor = StreamType.metalcore.backgroundColor
        liteLbl.textColor = .lightGray
    }
    
    private func setLiteView() {
        rockImageView.image = UIImage(named: "empty_arrow")
        metalcoreImageView.image = UIImage(named: "empty_arrow")
        liteImageView.image = UIImage(named: "lite_arrow")
        
        rockLbl.textColor = .lightGray
        metalcoreLbl.textColor = .lightGray
        liteLbl.textColor = StreamType.lite.backgroundColor
    }
    
    @objc
    private func rockStackViewClicked() {
        setRockView()
        currentStream = .rock
        if let title = currentSongRock {
            setSongsViews()
            delegate?.streamChanged(type: .rock, songName: title)
            homeViewModel?.updateData(songTitle: title)
        }
    }
    
    @objc
    private func metalcoreStackViewClicked() {
        setMetalView()
        currentStream = .metalcore
        if let title = currentSongMetal {
            setSongsViews()
            delegate?.streamChanged(type: .metalcore, songName: title)
            homeViewModel?.updateData(songTitle: title)
        }
    }
    
    @objc
    private func liteStackViewClicked() {
        setLiteView()
        currentStream = .lite
        if let title = currentSongLite {
            setSongsViews()
            delegate?.streamChanged(type: .lite, songName: title)
            homeViewModel?.updateData(songTitle: title)
        }
    }
}
