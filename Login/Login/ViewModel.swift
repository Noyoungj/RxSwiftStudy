//
//  File.swift
//  Login
//
//  Created by 노영재 on 2023/01/04.
//

import Foundation
import RxCocoa
import RxSwift
class ViewModel : NSObject {
    let emailObserver = BehaviorRelay<String>(value: "")
    let passwordObserver = BehaviorRelay<String>(value: "")

    var isValid: Observable<Bool> {
        print("dkdk")
        return Observable.combineLatest(emailObserver, passwordObserver)
            .map { email, password in
                print("Email : \(email), Password : \(password)")
                print(!email.isEmpty && email.contains("@") && email.contains(".") && password.count > 0)
                return !email.isEmpty && email.contains("@") && email.contains(".") && password.count > 0
            }
    }
    
    override init() {
    }
}
