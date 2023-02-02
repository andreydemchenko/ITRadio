//
//  AnimLoadingTrackView.swift
//  ITRadio
//
//  Created by zuzex-62 on 23.01.2023.
//

import UIKit
import RxSwift

class AnimLoadingTrackView: UIView {

    @IBOutlet private weak var view1: UIView?
    @IBOutlet private weak var view2: UIView?
    @IBOutlet private weak var view3: UIView?
    @IBOutlet private weak var view4: UIView?
    @IBOutlet private weak var view5: UIView?
    @IBOutlet private weak var playPauseImageView: UIImageView?
    
    private var isAnimation = false
    
    func setViews(state: PlayerState) {
        switch state {
        case .connect:
            isAnimation = true
            animation()
            playPauseImageView?.isHidden = true
            showAnimViews()
        case .play(type: _):
            isAnimation = false
            hideAnimViews()
            playPauseImageView?.isHidden = false
            playPauseImageView?.image = state.icon
        case .stop:
            isAnimation = false
            hideAnimViews()
            playPauseImageView?.isHidden = false
            playPauseImageView?.image = state.icon
        }
    }
    
    private func animation() {
        DispatchQueue.main.async {
            if self.isAnimation {
                UIView.animate(withDuration: 0.5, delay: 0, options: []) {
                    self.view1?.transform = CGAffineTransform(scaleX: 1, y: 3)
                }
                UIView.animate(withDuration: 0.5, delay: 0.1, options: []) {
                    self.view2?.transform = CGAffineTransform(scaleX: 1, y: 3)
                }
                UIView.animate(withDuration: 0.5, delay: 0.2, options: []) {
                    self.view3?.transform = CGAffineTransform(scaleX: 1, y: 3)
                }
                UIView.animate(withDuration: 0.5, delay: 0.3, options: []) {
                    self.view4?.transform = CGAffineTransform(scaleX: 1, y: 3)
                }
                UIView.animate(withDuration: 0.5, delay: 0.4, options: []) {
                    self.view5?.transform = CGAffineTransform(scaleX: 1, y: 3)
                }
                
                UIView.animate(withDuration: 0.5, delay: 0.2, options: []) {
                    self.view1?.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                UIView.animate(withDuration: 0.5, delay: 0.3, options: []) {
                    self.view2?.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                UIView.animate(withDuration: 0.5, delay: 0.4, options: []) {
                    self.view3?.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                UIView.animate(withDuration: 0.5, delay: 0.5, options: []) {
                    self.view4?.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                UIView.animate(withDuration: 0.5, delay: 0.6, options: []) {
                    self.view5?.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                if self.isAnimation {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if self.isAnimation {
                            self.animation()
                        } else {
                            self.removeAllAnimations()
                        }
                    }
                } else {
                    self.removeAllAnimations()
                }
            } else {
                self.removeAllAnimations()
            }
        }
    }
    
    private func removeAllAnimations() {
        view1?.layer.removeAllAnimations()
        view2?.layer.removeAllAnimations()
        view3?.layer.removeAllAnimations()
        view4?.layer.removeAllAnimations()
        view5?.layer.removeAllAnimations()
    }
    
    private func hideAnimViews() {
        view1?.isHidden = true
        view2?.isHidden = true
        view3?.isHidden = true
        view4?.isHidden = true
        view5?.isHidden = true
    }
    
    private func showAnimViews() {
        view1?.isHidden = false
        view2?.isHidden = false
        view3?.isHidden = false
        view4?.isHidden = false
        view5?.isHidden = false
    }
    
}
