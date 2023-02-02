//
//  URL+Ext.swift
//  ITRadio
//
//  Created by zuzex-62 on 30.01.2023.
//

import Foundation

extension URL {
    
    func getData(completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: self, completionHandler: completion).resume()
    }
    
}
