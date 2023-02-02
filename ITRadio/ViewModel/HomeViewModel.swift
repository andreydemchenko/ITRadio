//
//  ViewModel.swift
//  ITRadio
//
//  Created by zuzex-62 on 16.01.2023.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

enum RateTrackType {
    case like
    case dislike
    
    var value: Bool {
        switch self {
        case .like:
            return true
        case .dislike:
            return false
        }
    }
}

class HomeViewModel {
    
    enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    enum TrackError {
        case internetError(String)
        case serverMessage(String)
    }

    let rockTracks: PublishSubject<TrackResponse> = PublishSubject()
    let metalcoreTracks: PublishSubject<TrackResponse> = PublishSubject()
    let liteTracks: PublishSubject<TrackResponse> = PublishSubject()
    let loadingStreams: PublishSubject<Bool> = PublishSubject()
    let streamsError: PublishSubject<HomeError> = PublishSubject()
    
    let trackDetails: PublishSubject<GetTrackDetailsQuery.Data.TrackV2> = PublishSubject()
    let loadingTrack: PublishSubject<Bool> = PublishSubject()
    let trackError: PublishSubject<TrackError> = PublishSubject()
    
    var dataSource: PublishSubject<[StreamModel]> = PublishSubject()
    
    private let disposeBag = DisposeBag()
    private let networkManager = appContext.networkManager
    private var rockTitle: String?
    private var metalcoreTitle: String?
    private var liteTitle: String?
    private var streamTypePlaying: StreamType?
    
    func requestData() {
        loadingStreams.onNext(true)
        let group = DispatchGroup()
        group.enter()
        networkManager.getTracks(type: .rock) { [weak self] result in
            switch result {
            case .success(let tracks):
                self?.rockTracks.onNext(tracks)
                self?.rockTitle = tracks.track?.current?.title
            case .failure(let error):
                print("Error occurred with getting rock tracks: \(error.localizedDescription)")
                self?.streamsError.onNext(.serverMessage(error.localizedDescription))
            }
            group.leave()
        }
        group.enter()
        appContext.networkManager.getTracks(type: .metalcore) { [weak self] result in
            switch result {
            case .success(let tracks):
                self?.metalcoreTracks.onNext(tracks)
                self?.metalcoreTitle = tracks.track?.current?.title
            case .failure(let error):
                print("Error occurred with getting metalcore tracks: \(error.localizedDescription)")
                self?.streamsError.onNext(.serverMessage(error.localizedDescription))
            }
            group.leave()
        }
        group.enter()
        appContext.networkManager.getTracks(type: .lite) { [weak self] result in
            switch result {
            case .success(let tracks):
                self?.liteTracks.onNext(tracks)
                self?.liteTitle = tracks.track?.current?.title
            case .failure(let error):
                print("Error occurred with getting lite tracks: \(error.localizedDescription)")
                self?.streamsError.onNext(.serverMessage(error.localizedDescription))
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.loadingStreams.onNext(false)
        }
        observeTracks()
    }
    
    private func observeTracks() {
        rockTracks.observe(on: MainScheduler.instance)
            .subscribe(onNext: { value in
                self.setData()
            })
            .disposed(by: disposeBag)
        metalcoreTracks.observe(on: MainScheduler.instance)
            .subscribe(onNext: { value in
                self.setData()
            })
            .disposed(by: disposeBag)
        liteTracks.observe(on: MainScheduler.instance)
            .subscribe(onNext: { value in
                self.setData()
            })
            .disposed(by: disposeBag)
        appContext.audioPlayer.state
            .subscribe(onNext: { value in
                switch value {
                case let .play(type: type):
                    self.streamTypePlaying = type
                case .stop:
                    self.streamTypePlaying = nil
                case .connect:
                    self.streamTypePlaying = nil
                }
                self.setData()
            })
            .disposed(by: disposeBag)
    }
    
    func setData() {
        var isListeningRock = false
        var isListeningMc = false
        var isListeningLite = false
        if let streamTypePlaying {
            switch streamTypePlaying {
            case .rock:
                isListeningRock = true
            case .metalcore:
                isListeningMc = true
            case .lite:
                isListeningLite = true
            }
        }
        var dataSource: [StreamModel] = []
        let rockModel = StreamModel(name: .rock, description: "Говорят, что рок – музыка протеста, не верьте, ведь рок — это свобода!", currentSong: rockTitle ?? "Loading...", isListening: isListeningRock, image: UIImage(named: "image_rock")!)
        let metalcoreModel = StreamModel(name: .metalcore, description: "Объединяет экстремальный метал и хардкор-панк.", currentSong: metalcoreTitle ?? "Loading...", isListening: isListeningMc, image: UIImage(named: "image_metalcore")!)
        let liteModel = StreamModel(name: .lite, description: "Запоминающиеся мелодии признанных мировых хитов.", currentSong: liteTitle ?? "Loading...", isListening: isListeningLite, image: UIImage(named: "image_lite")!)
        dataSource.append(rockModel)
        dataSource.append(metalcoreModel)
        dataSource.append(liteModel)
        self.dataSource.onNext(dataSource)
    }
    
    func requestSongDetails(songTitle: String) {
        loadingTrack.onNext(true)
        appContext.apolloClient.fetch(query: GetTrackDetailsQuery(title: songTitle)) { [weak self] result in
            self?.loadingTrack.onNext(false)
            switch result {
            case .success(let data):
                if let trackDetails = data.data?.trackV2 {
                    self?.trackDetails.onNext(trackDetails)
                } else {
                    self?.trackError.onNext(.serverMessage("No data"))
                }
            case .failure(let error):
                self?.trackError.onNext(.serverMessage(error.localizedDescription))
            }
        }
    }
    
    func requestRateTrack(id: String, type: RateTrackType) {
        appContext.apolloClient.perform(mutation: RateV2Mutation(trackId: id, rating: type.value)) { result in
            switch result {
            case .success(let response):
                print("there are some data")
                if let data = response.data {
                    print(data)
                }
            case .failure(let error):
                print("An error occurred with rating track: \(error.localizedDescription)")
            }
        }
    }
    
    func updateData(songTitle: String) {
        requestData()
        requestSongDetails(songTitle: songTitle)
    }
    
    func requestEditProfile(username: String, gender: String?, birthday: Date?) {
        //appContext.apolloClient.perform(mutation: ProfileV2Query())
    }
    
    func requestSendFeedback(text: String) {
        appContext.apolloClient.perform(mutation: FeedbackMutation(text: text)) { result in
            switch result {
            case .success(_): break;
            case .failure(let error):
                print("An error occurred with sending feedback: \(error.localizedDescription)")
            }
        }
    }
    
}
