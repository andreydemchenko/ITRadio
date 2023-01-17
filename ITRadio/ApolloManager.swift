//
//  ApolloManager.swift
//  ITRadio
//
//  Created by zuzex-62 on 17.01.2023.
//

import Apollo
import Foundation

class ApolloManager {
    lazy var apolloClient = ApolloClient(url: URL(string: "https://it-radio.ru/graphql")!)
}
