//
//  FavoritesViewModel.swift
//  ITRadio
//
//  Created by zuzex-62 on 30.01.2023.
//

import Foundation
import RxSwift
import RxCocoa

class FavoritesViewModel {
    
    var dataSource: PublishSubject<[RatingsQuery.Data.Rating?]> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    func requestRatingsTracks() {
        appContext.apolloClient.fetch(query: RatingsQuery()) { [weak self] result in
            switch result {
            case .success(let response):
                if let data = response.data?.ratings {
                    self?.dataSource.onNext(data)
                } else {
                    print("Favorites are empty")
                }
            case .failure(let error):
                print("An error occurred with getting ratings: \(error.localizedDescription)")
            }
        }
    }
    
}
