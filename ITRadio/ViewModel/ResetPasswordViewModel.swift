//
//  RecoveryPasswordViewModel.swift
//  ITRadio
//
//  Created by zuzex-62 on 03.02.2023.
//

import Foundation
import RxSwift
import RxCocoa

class RecoveryPasswordViewModel {
    
    let emailSubject = BehaviorRelay<String?>(value: "")
    
    var isValidForm: Observable<Bool> {
        return Observable.just(emailSubject.value != nil && emailSubject.value!.validateEmail())
    }
    
}
