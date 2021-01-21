//
//  SecondViewModel.swift
//  XCoordinatorDemo
//
//  Created by Van Tien Tu on 21/01/2021.
//

import UIKit
import RxSwift

class SecondViewModel {
    let bag = DisposeBag()
    
    struct Input {
        let dismissTriggered: Observable<Void>
        let presentTriggered: Observable<Void>
    }
    
    struct Output {
        
    }
    
    private let _dismissTriggered = PublishSubject<Void>()
    var dismissTriggered: Observable<Void> {
        return self._dismissTriggered.asObservable()
    }
    
    private let _presentTriggered = PublishSubject<Void>()
    var presentTriggered: Observable<Void> {
        return self._presentTriggered.asObservable()
    }
    
    init() {
        print("[info] inited SecondViewModel")
    }
    
    func transform(_ input: Input) -> Output {
        
        input.dismissTriggered
            .bind(to: self._dismissTriggered)
            .disposed(by: self.bag)
        input.presentTriggered
            .bind(to: self._presentTriggered)
            .disposed(by: self.bag)
            
        
        return Output()
    }
    
    deinit {
        print("[info] deinited SecondViewModel")
    }
}
