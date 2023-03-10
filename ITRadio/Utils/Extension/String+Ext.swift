//
//  String+ Ext.swift
//  ITRadio
//
//  Created by zuzex-62 on 03.02.2023.
//

import Foundation

extension String {
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
