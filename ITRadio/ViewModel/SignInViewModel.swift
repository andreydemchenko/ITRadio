//
//  AuthorizationViewModel.swift
//  ITRadio
//
//  Created by zuzex-62 on 27.01.2023.
//

import Foundation
import RxSwift
import RxCocoa

class SignImViewModel {
    
    let signInError: PublishSubject<String> = PublishSubject()
    let signOutError: PublishSubject<String> = PublishSubject()
    let isUserLoggedIn: PublishSubject<Bool> = PublishSubject()
    
    func setAuthorizationToken(token: String?) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "authorizationToken")
    }
    
    func setUsername(name: String?) {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "username")
    }
    
    func requestSignIn(email: String, password: String) {
        appContext.apolloClient.perform(mutation: LoginV2Mutation(email: email, password: password)) { [weak self] result in
            switch result {
            case .success(let response):
                if let data = response.data?.loginV2 {
                    self?.isUserLoggedIn.onNext(true)
                    self?.setAuthorizationToken(token: data)
                    self?.requestProfileData()
                } else {
                    self?.isUserLoggedIn.onNext(false)
                    self?.signInError.onNext("There is no data")
                }
            case .failure(let error):
                self?.isUserLoggedIn.onNext(false)
                self?.signInError.onNext(error.localizedDescription)
            }
        }
    }
    
    func requestSignOut() {
        appContext.apolloClient.perform(mutation: LogoutMutation()) { [weak self] result in
            switch result {
            case .success(let data):
                self?.setAuthorizationToken(token: nil)
                self?.isUserLoggedIn.onNext(false)
                if let response = data.data?.logout {
                    print("logout response = \(response)")
                }
                self?.setUsername(name: nil)
            case .failure(let error):
                self?.signOutError.onNext(error.localizedDescription)
            }
        }
    }
    
    func requestProfileData() {
        appContext.apolloClient.fetch(query: ProfileV2Query()) { [weak self] result in
            switch result {
            case .success(let response):
                print(response.data?.profileV2)
                if let username = response.data?.profileV2?.username {
                    self?.setUsername(name: username)
                }
            case .failure(let error):
                print("An error occurred with getting profile data: \(error.localizedDescription)")
            }
        }
    }
    
}
