//
//  AudioPlayer.swift
//  ITRadio
//
//  Created by zuzex-62 on 18.01.2023.
//

import Foundation
import AVFoundation
import MediaPlayer
import RxSwift
import RxCocoa

protocol AudioPlayerProtocol: AnyObject {
    func stateChanged(state: PlayerState)
}

/*
enum PlayerState {
    case connect
    case play
    case stop
    
    var icon: UIImage {
        switch self {
        case .connect: return .init()
        case .play: return #imageLiteral(resourceName: "pause_icon")
        case .stop: return #imageLiteral(resourceName: "play_icon")
        }
    }
}

class AudioPlayer: NSObject {
    
    public var delegate: AudioPlayerProtocol?
    
    public var state: PlayerState = .stop {
        didSet {
            delegate?.stateChanged(state: state)
        }
    }
    
    public var onShowError = String()
    private var timeoutWorker: DispatchWorkItem?
    private var player: AVPlayer!
    private var type: StreamType?
    
    override init() {
        super.init()
        initPlayer()
    }
    
    public func play(type: StreamType) {
        self.type = type
        setAudioSession(active: true)
        addPlayerItem(type: type)
        player.play()
        state = .connect
    }
    
    public func stop() {
        player.pause()
        removePlayerItem()
        state = .stop
    }
    
    private func initPlayer() {
        
        player = AVPlayer()
        player.allowsExternalPlayback = false
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: AVAudioSession.RouteSharingPolicy.longFormAudio)
        } catch {
            NSLog("Config AVAudioSession error")
        }
        
        
        
    }
    
    public func setAudioSession(active: Bool) {
        NSLog(#function, "active: \(active)")
        do {
            try AVAudioSession.sharedInstance().setActive(active)
        } catch  {
            NSLog(#function, ": AVAudioSession change active state error")
        }
    }
    
    
    private func addPlayerItem(type: StreamType) {
        guard let radioUrl = URL(string: type.streamUrl) else { NSLog("RADIO URL NILL"); return }
        let asset = AVAsset(url: radioUrl)
        let playerItem = AVPlayerItem(asset: asset)
        let metadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
        metadataOutput.setDelegate(self, queue: DispatchQueue.main)
        playerItem.add(metadataOutput)
        player.replaceCurrentItem(with: playerItem)
    }
    
    private func removePlayerItem() {
        player.replaceCurrentItem(with: nil)
    }
    
    
    private func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self, name: AVAudioSession.interruptionNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: AVAudioSession.routeChangeNotification, object: nil)
    }
    
    func setupNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.handleInterruption(notification:)),
                                               name: AVAudioSession.interruptionNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleRouteChange),
                                               name: AVAudioSession.routeChangeNotification,
                                               object: nil)
      
    }
    
    // MARK: - Notification handlers
    
    @objc
    private func handleLostConnection() {
        stop()
    }

    @objc
    private func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
                return
        }

        switch reason {
        case .oldDeviceUnavailable: // Old device removed.
            self.stop()
        default:
            break
        }
    }
    
    @objc
    private func handleInterruption(notification: Notification) {
        // Retrieve the interruption type from the notification.
        
        guard let userInfo = notification.userInfo,
            let interruptionTypeUInt = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let interruptionType = AVAudioSession.InterruptionType(rawValue: interruptionTypeUInt) else { return }
        
        switch interruptionType {
        case .began:
            stop()
        case .ended:
            // When an interruption ends, determine whether playback should resume
            // automatically, and reactivate the audio session if necessary.
            self.setAudioSession(active: true)
            
            if let optionsUInt = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt,
                AVAudioSession.InterruptionOptions(rawValue: optionsUInt).contains(.shouldResume) {
                if let type {
                    play(type: type)
                }
            }
        @unknown default: break
        }
    }

    func handlePlayerStatusChange() {
        if let playerItem = self.player.currentItem {
            if let error = playerItem.error as NSError? {
                NSLog("ERROR: - ", error.localizedDescription)
            }
        }
    }
    
    @objc
    func handleTimeControlStatusChange() {
        let status = self.player.timeControlStatus
        if status == .playing  {
            state = .play
            timeoutWorker?.cancel()
            NSLog("MUSIC PLAING")
        } else if status == .paused {
            NSLog("MUSIC PAUSED")
            state = .stop
            timeoutWorker?.cancel()
        }
    }
    
    private func createTimeoutWorkerIfNeed() {
        self.timeoutWorker?.cancel()
        self.timeoutWorker = DispatchWorkItem(block: {
            self.stop()
            self.onShowError = "Превышено время ожидания!"
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0, execute: self.timeoutWorker!)
    }
    
    deinit {
        unsubscribeFromNotifications()
    }
    
}

extension AudioPlayer: AVPlayerItemMetadataOutputPushDelegate {
    
    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {
        var songTitle: String = ""
        
        if let item = groups.first?.items.first {
            item.value(forKeyPath: "value")
            songTitle = (item.value(forKeyPath: "value")!) as? String ?? ""
        }

    }
}

*/

enum PlayerState {
    case connect
    case play(type: StreamType)
    case stop
    
    var icon: UIImage {
        switch self {
        case .connect: return .init()
        case .play: return #imageLiteral(resourceName: "pause_icon")
        case .stop: return #imageLiteral(resourceName: "play_icon")
        }
    }
    
    var isPlaying: Bool {
        switch self {
        case .connect:
            return true
        case .play:
            return true
        case .stop:
            return false
        }
    }
}

class AudioPlayer: NSObject {
    
    public var state = BehaviorRelay<PlayerState>(value: .stop)
    
    private var type: StreamType?
    
    public var currentTrack = PublishRelay<GetTrackDetailsQuery.Data.TrackV2>()
    public var onShowError = PublishRelay<String>()
    
    private var playerStatusObserver: NSKeyValueObservation!
    private var timeControlStatusObserver: NSKeyValueObservation!
    
    private var timeoutWorker: DispatchWorkItem?
    private var player: AVPlayer!
    private var disposeBag = DisposeBag()
    
    override init() {
        super.init()
        setupNotifications()
        controlFromRemote()
        initPlayer()
    }
        
    public func play(type: StreamType) {
        self.type = type
        setAudioSession(active: true)
        addPlayerItem(type: type)
        player.play()
        state.accept(.connect)
        createTimeoutWorkerIfNeed()
    }
    
    public func stop() {
        player.pause()
        removePlayerItem()
        state.accept(.stop)
        timeoutWorker?.cancel()
    }
    
    private func initPlayer() {
        
        player = AVPlayer()
        player.allowsExternalPlayback = false

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: AVAudioSession.RouteSharingPolicy.longFormAudio)
        } catch {
            NSLog("Config AVAudioSession error")
        }

        playerStatusObserver = self.player.observe(\.currentItem?.status, options: .new) { [unowned self] _, _ in
            self.handlePlayerStatusChange()
        }
        
        timeControlStatusObserver = self.player.observe(\.timeControlStatus, options: [.new, .old]) { [unowned self] _, _ in
            self.handleTimeControlStatusChange()
        }
        
        currentTrack
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { [weak self] track in
                self?.updateInfoCenter(title: track.track ?? track.title,
                                       artist: track.artist,
                                       album: track.album,
                                       release: track.release,
                                       genre: track.genre,
                                       coverImageUrl: track.cover?.big)
            })
            .disposed(by: disposeBag)
    }
    
    public func setAudioSession(active: Bool) {
        NSLog(#function, "active: \(active)")
        do {
            try AVAudioSession.sharedInstance().setActive(active)
        } catch  {
            NSLog(#function, ": AVAudioSession change active state error")
        }
    }
    
    deinit {
        unsubscribeFromNotifications()
        playerStatusObserver = nil
        timeControlStatusObserver = nil
    }
    
    // This two metods (addPlayerItem and removePlayerItem) is used for stop buffering audio from stream
    
    private func addPlayerItem(type: StreamType) {
        guard let radioUrl = URL(string: type.streamUrl) else { NSLog("RADIO URL NILL"); return }
        let asset = AVAsset(url: radioUrl)
        let playerItem = AVPlayerItem(asset: asset)
        let metadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
        metadataOutput.setDelegate(self, queue: DispatchQueue.main)
        playerItem.add(metadataOutput)
        player.replaceCurrentItem(with: playerItem)
    }
    
    private func removePlayerItem() {
        player.replaceCurrentItem(with: nil)
    }
    
    // MARK: - Controll audio from background
    
    private func controlFromRemote() {
        
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget(handler: { (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
            self.playFromBackground(MPRemoteCommandEvent)
            return MPRemoteCommandHandlerStatus.success
        })
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget(handler: { (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
            self.pauseFromBackground(MPRemoteCommandEvent)
            return MPRemoteCommandHandlerStatus.success
        })
        
        commandCenter.togglePlayPauseCommand.isEnabled = true
        commandCenter.togglePlayPauseCommand.addTarget(handler: { (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
            self.toggleFromBackground(MPRemoteCommandEvent)
            return MPRemoteCommandHandlerStatus.success
        })
        
        commandCenter.previousTrackCommand.isEnabled = false
        commandCenter.nextTrackCommand.isEnabled  = false
        
    }
    
    private func playFromBackground(_ event: MPRemoteCommandEvent) {
        if let type {
            play(type: type)
        }
    }
    
    private func pauseFromBackground(_ event: MPRemoteCommandEvent) {
        stop()
    }
    
    private func toggleFromBackground(_ event: MPRemoteCommandEvent) {
        switch state.value {
        case .connect:
            break
        case .play(type: _):
            stop()
        case .stop:
            if let type {
                play(type: type)
            }
        }
    }
    
    private func restart() {
        switch state.value {
        case .connect:
            break
        case .play(type: _):
            stop()
            if let type {
                play(type: type)
            }
        case .stop:
            break
        }
    }
    
    // MARK: - Update song information on lock screen
    
    private func updateInfoCenter(title: String?, artist: String?, album: String?, release: String?, genre: String?, coverImageUrl: String?) {
        var info : [String : AnyObject] = [
            MPMediaItemPropertyMediaType : MPMediaType.anyAudio.rawValue as AnyObject
        ]
        var albumTitle: String?
        if let release = release {
            albumTitle = (album ?? "") + " - \(release)"
        } else {
            albumTitle = album
        }
        
        info[MPMediaItemPropertyTitle] = title as AnyObject    // Song title
        info[MPMediaItemPropertyArtist]     = artist as AnyObject? // Song artist
        info[MPMediaItemPropertyAlbumTitle] = albumTitle as AnyObject?  // Song album title + album release
        info[MPMediaItemPropertyGenre] = genre as AnyObject? // Song genre
        info[MPNowPlayingInfoPropertyIsLiveStream] = true as AnyObject?    // Live stream
        info[MPMediaItemPropertyReleaseDate] = release as AnyObject? // Song release data
    
        if let coverImageUrl = coverImageUrl,
           let url = URL(string: coverImageUrl),
           let coverImageData = try? Data(contentsOf: url),
           let coverImage = UIImage(data: coverImageData) {
            info[MPMediaItemPropertyArtwork] = MPMediaItemArtwork.init(boundsSize: coverImage.size, requestHandler: { (size) -> UIImage in
                return coverImage
            })
        }
        MPNowPlayingInfoCenter.default().nowPlayingInfo = info
    }
    
    // MARK: - Creating notifications
    
    private func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self, name: AVAudioSession.interruptionNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: AVAudioSession.routeChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: nil)
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
    }
    
    func setupNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.handleInterruption(notification:)),
                                               name: AVAudioSession.interruptionNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleRouteChange),
                                               name: AVAudioSession.routeChangeNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.handleLostConnection),
                                               name: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime,
                                               object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didChangeAppSettingsHandler(_:)),
            name: UserDefaults.didChangeNotification,
            object: nil
        )
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(didChangeNetworkManagerConnectionTypeHandler(_:)),
//            name: .didChangeNetworkManagerConnectionType,
//            object: nil
//        )
    }
    
    // MARK: - Notification handlers
    
    @objc
    private func handleLostConnection() {
        stop()
    }

    @objc
    private func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
                return
        }

        switch reason {
        case .oldDeviceUnavailable: // Old device removed.
            self.stop()
        default:
            break
        }
    }
    
    @objc
    private func handleInterruption(notification: Notification) {
        // Retrieve the interruption type from the notification.
        
        guard let userInfo = notification.userInfo,
            let interruptionTypeUInt = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let interruptionType = AVAudioSession.InterruptionType(rawValue: interruptionTypeUInt) else { return }
        
        switch interruptionType {
        case .began:
            stop()
        case .ended:
            // When an interruption ends, determine whether playback should resume
            // automatically, and reactivate the audio session if necessary.
            setAudioSession(active: true)
            
            if let optionsUInt = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt,
                AVAudioSession.InterruptionOptions(rawValue: optionsUInt).contains(.shouldResume) {
                if let type {
                    play(type: type)
                }
            }
        @unknown default: break
        }
    }
    
    @objc
    private func didChangeAppSettingsHandler(_ notification: Notification) {
        restart()
    }
    
    @objc
    private func didChangeNetworkManagerConnectionTypeHandler(_ notification: Notification) {
//        if AppSettings.standart.bitrate == .auto {
//            restart()
//        }
    }

    func handlePlayerStatusChange() {
        if let playerItem = self.player.currentItem {
            if let error = playerItem.error as NSError? {
                NSLog("ERROR: - ", error.localizedDescription)
            }
        }
    }
    
    func handleTimeControlStatusChange() {
        let status = self.player.timeControlStatus
        if status == .playing  {
            if let type {
                state.accept(.play(type: type))
                timeoutWorker?.cancel()
                NSLog("MUSIC PLAING")
            }
        } else if status == .paused {
            NSLog("MUSIC PAUSED") // not real end
            state.accept(.stop)
            timeoutWorker?.cancel()
        }
    }
    
    private func createTimeoutWorkerIfNeed() {
        timeoutWorker?.cancel()
        timeoutWorker = DispatchWorkItem(block: { [self] in
            appContext.audioPlayer.stop()
            onShowError.accept("Превышено время ожидания!")
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0, execute: self.timeoutWorker!)
    }
}

// MARK: - AVPlayerItemMetadataOutputPushDelegate

extension AudioPlayer: AVPlayerItemMetadataOutputPushDelegate {
    
    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {
        var songTitle: String = ""
        
        if let item = groups.first?.items.first {
            item.value(forKeyPath: "value")
            songTitle = (item.value(forKeyPath: "value")!) as? String ?? ""
        }
        appContext.homeViewModel.updateData(songTitle: songTitle)
    }
}
