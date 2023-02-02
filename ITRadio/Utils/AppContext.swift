//
//  AppContext.swift
//  ITRadio
//
//  Created by zuzex-62 on 18.01.2023.
//

import Apollo
import Foundation

let appContext = AppContext()
class AppContext {
    lazy var networkManager = NetworkManager()
    lazy var audioPlayer = AudioPlayer()
    
    lazy var apolloClient = {
        let apolloURL = URL(string: "https://it-radio.ru/graphql")!
        let store = ApolloStore()
        let interceptorProvider = NetworkInterceptorsProvider(
            interceptors: [TokenInterceptor(token: appContext.getAuthorizationToken())],
            store: store)
        let networkTransport = RequestChainNetworkTransport(
            interceptorProvider: interceptorProvider, endpointURL: apolloURL)
        
        return ApolloClient(networkTransport: networkTransport, store: store)
    }()
    lazy var homeViewModel = HomeViewModel()
    lazy var authorizationViewModel = AuthorizationViewModel()
    lazy var favoritesViewModel = FavoritesViewModel()
    
    func getAuthorizationToken() -> String {
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: "authorizationToken") {
            return token
        }
        return ""
    }
    
    func getUsername() -> String {
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: "username") {
            return token
        }
        return "username"
    }
  
}
