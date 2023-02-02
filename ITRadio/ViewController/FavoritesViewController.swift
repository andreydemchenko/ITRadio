//
//  FavoritesViewController.swift
//  ITRadio
//
//  Created by zuzex-62 on 27.01.2023.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: UIViewController {
    
    @IBOutlet private weak var likesView: UIView!
    @IBOutlet private weak var dislikesView: UIView!
    @IBOutlet private weak var tracksStackView: UIStackView!
    
    private let disposeBag = DisposeBag()
    private weak var viewModel = appContext.favoritesViewModel
    
    private var type: RateTrackType = .like {
        didSet {
            if type == .like {
                likesView.backgroundColor = UIColor(red: 215/255, green: 91/255, blue: 60/255, alpha: 1)
                dislikesView.backgroundColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1)
            } else {
                dislikesView.backgroundColor = UIColor(red: 215/255, green: 91/255, blue: 60/255, alpha: 1)
                likesView.backgroundColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likesView.layer.borderWidth = 1
        likesView.layer.borderColor = UIColor.white.cgColor
        dislikesView.layer.borderWidth = 1
        dislikesView.layer.borderColor = UIColor.white.cgColor
        
        let likesTap = UITapGestureRecognizer(target: self, action: #selector(likesViewTapped))
        let dislikesTap = UITapGestureRecognizer(target: self, action: #selector(dislikesViewTapped))
        likesView.addGestureRecognizer(likesTap)
        dislikesView.addGestureRecognizer(dislikesTap)
        
        viewModel?.requestRatingsTracks()
        setupBinding()
    }
    
    @objc
    private func likesViewTapped() {
        type = .like
        viewModel?.requestRatingsTracks()
    }
    
    @objc
    private func dislikesViewTapped() {
        type = .dislike
        viewModel?.requestRatingsTracks()
    }
    
    private func setupBinding() {
        viewModel?.dataSource
            .subscribe(onNext: { [weak self] value in
                self?.tracksStackView.removeAllArrangedSubviews()
                value.forEach { item in
                    if let view = Bundle.main.loadNibNamed("FavoritesTrackView", owner: self, options: nil)?.first as? FavoritesTrackView {
                        view.delegate = self
                        if self?.type == .like, let rating = item?.rating, rating {
                            view.setViews(model: item)
                            self?.tracksStackView.addArrangedSubview(view)
                        } else if self?.type == .dislike, let rating = item?.rating, !rating  {
                            view.setViews(model: item)
                            self?.tracksStackView.addArrangedSubview(view)
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
    }

}

extension FavoritesViewController: FavoritesTrackProtocol {
    
    func trackClicked(model: RatingsQuery.Data.Rating?) {
        let vc = InfoTrackViewController(nibName: "InfoTrackViewController", bundle: nil)
        vc.data = model
        present(vc, animated: true)
    }
    
}
