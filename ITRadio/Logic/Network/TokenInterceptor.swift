//
//  TokenInterseptor.swift
//  ITRadio
//
//  Created by zuzex-62 on 30.01.2023.
//

import Foundation
import Apollo

class TokenInterceptor: ApolloInterceptor {
    
    let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : GraphQLOperation {
            request.addHeader(name: "Authorization", value: "\(token)")
            chain.proceedAsync(request: request, response: response, completion: completion)
    }
    
}
