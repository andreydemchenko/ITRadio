//
//  ViewController.swift
//  ITRadio
//
//  Created by zuzex-62 on 16.01.2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private weak var homeViewModel: HomeViewModel?
    
    private var dataSource: [StreamModel] = []
    private var rockTracks = TrackResponse()
    private var metalTracks = TrackResponse()
    private var liteTracks = TrackResponse()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*tableView.register(UINib(nibName: "StreamTableViewCell", bundle: nil), forCellReuseIdentifier: "StreamCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        addContent()*/
        homeViewModel = appContext.homeViewModel
        homeViewModel?.requestData()
        setupBinding()
    }
    
    private func setupBinding() {
        tableView.register(UINib(nibName: "StreamTableViewCell", bundle: nil), forCellReuseIdentifier: "StreamCell")
        homeViewModel?.dataSource.bind(to: tableView.rx.items(cellIdentifier: "StreamCell", cellType: StreamTableViewCell.self)) { (row, stream, cell) in
            cell.setViews(item: stream)
            cell.delegate = self
        }.disposed(by: disposeBag)
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
   /*
    func reloadStreams(source: [StreamModel]) {
        dataSource.removeAll()
        dataSource = source
        tableView.reloadData()
    }
    
    private func addContent() {
        let rockModel = StreamModel(name: .rock, description: "Говорят, что рок – музыка протеста, не верьте, ведь рок — это свобода!", currentSong: "Loading...", isListening: true, image: UIImage(named: "image_rock")!)
        let metalcoreModel = StreamModel(name: .metalcore, description: "Объединяет экстремальный метал и хардкор-панк.", currentSong: "Loading...", isListening: false, image: UIImage(named: "image_metalcore")!)
        let liteModel = StreamModel(name: .lite, description: "Запоминающиеся мелодии признанных мировых хитов.", currentSong: "Loading...", isListening: false, image: UIImage(named: "image_lite")!)
        dataSource.append(rockModel)
        dataSource.append(metalcoreModel)
        dataSource.append(liteModel)
        
        let group = DispatchGroup()
        group.enter()
        appContext.networkManager.getTracks(type: .rock) { [weak self] result in
            switch result {
            case .success(let tracks):
                self?.rockTracks = tracks
            case .failure(let error):
                print("Error occurred with getting rock tracks: \(error.localizedDescription)")
            }
            group.leave()
        }
        group.enter()
        appContext.networkManager.getTracks(type: .metalcore) { [weak self] result in
            switch result {
            case .success(let tracks):
                self?.metalTracks = tracks
            case .failure(let error):
                print("Error occurred with getting metalcore tracks: \(error.localizedDescription)")
            }
            group.leave()
        }
        group.enter()
        appContext.networkManager.getTracks(type: .lite) { [weak self] result in
            switch result {
            case .success(let tracks):
                self?.liteTracks = tracks
            case .failure(let error):
                print("Error occurred with getting lite tracks: \(error.localizedDescription)")
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.setData(streamTypePlaying: nil)
        }
        
    }
    
    func setData(streamTypePlaying: StreamType?) {
        var isListeningRock = false
        var isListeningLite = false
        var isListeningMc = false
        if let streamTypePlaying {
            if streamTypePlaying == .rock {
                isListeningRock = true
            } else if streamTypePlaying == .lite {
                isListeningLite = true
            } else if streamTypePlaying == .metalcore {
                isListeningMc = true
            }
        }
        
        dataSource.removeAll()
        let rockModel = StreamModel(name: .rock, description: "Говорят, что рок – музыка протеста, не верьте, ведь рок — это свобода!", currentSong: rockTracks.track?.current?.title ?? "No network", isListening: isListeningRock, image: UIImage(named: "image_rock")!)
        let metalcoreModel = StreamModel(name: .metalcore, description: "Объединяет экстремальный метал и хардкор-панк.", currentSong: metalTracks.track?.current?.title ?? "No network", isListening: isListeningMc, image: UIImage(named: "image_metalcore")!)
        let liteModel = StreamModel(name: .lite, description: "Запоминающиеся мелодии признанных мировых хитов.", currentSong: liteTracks.track?.current?.title ?? "No network", isListening: isListeningLite, image: UIImage(named: "image_lite")!)
        dataSource.append(rockModel)
        dataSource.append(metalcoreModel)
        dataSource.append(liteModel)
        tableView.reloadData()
    }*/

}

extension HomeViewController: UITableViewDelegate {
    
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StreamCell", for: indexPath) as? StreamTableViewCell else {
            fatalError("Could not dequeue cell of type NewsTableViewCell")
        }
        cell.setViews(item: dataSource[indexPath.row])
        cell.delegate = self
        return cell
    }*/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIWindow.isLandscape {
            return 680.0
        } else {
            return 485.0
        }
    }
}

extension HomeViewController: StreamCellProtocol {
    
    func setPause(exceptType: StreamType) {
        //setData(streamTypePlaying: exceptType)
    }
    
    func songClicked(title: String, type: StreamType, isPlaying: Bool) {
        let vc = TrackViewController(nibName: "TrackViewController", bundle: nil)
        vc.songTitle = title
        vc.type = type
        vc.isPlaying = isPlaying
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
