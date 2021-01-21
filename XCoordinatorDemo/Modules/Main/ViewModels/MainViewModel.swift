//
//  MainViewModel.swift
//  XCoordinatorDemo
//
//  Created by Van Tien Tu on 21/01/2021.
//

import UIKit
import RxSwift

class MainViewModel {
    
    let bag = DisposeBag()
    
    struct Input {
        let presentTriggered: Observable<Void>
        let pushTriggered: Observable<Void>
    }
    
    struct Output {
        
    }
    
    private let _presentTriggered = PublishSubject<Void>()
    var presentTriggered: Observable<Void> {
        return self._presentTriggered.asObservable()
    }
    
    private let _pushTriggered = PublishSubject<Void>()
    var pushTriggered: Observable<Void> {
        return self._pushTriggered.asObservable()
    }
    
    init() {
        print("[info] inited MainViewModel")
    }
    
    func transform(_ input: Input) -> Output {
        
        input.presentTriggered
            .bind(to: self._presentTriggered)
            .disposed(by: self.bag)
        input.pushTriggered
            .bind(to: self._pushTriggered)
            .disposed(by: self.bag)
        
        return Output()
    }
    
    deinit {
        print("[info] deinited MainViewModel")
    }
}
