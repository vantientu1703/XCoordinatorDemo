//
//  IntroViewModel.swift
//  XCoordinatorDemo
//
//  Created by Van Tien Tu on 22/01/2021.
//

import UIKit
import RxSwift

class IntroViewModel {
    let bag = DisposeBag()
    
    struct Input {
        let viewDidAppear: Observable<Void>
    }
    
    struct Output {
        
    }
    
    private let _viewDidAppear = PublishSubject<Void>()
    var viewDidAppear: Observable<Void> {
        return self._viewDidAppear.asObservable()
    }
    
    init() {
        print("[info] inited IntroViewModel")
    }
    
    func transform(_ input: Input) -> Output {
        
        input.viewDidAppear
            .bind(to: self._viewDidAppear)
            .disposed(by: self.bag)
        
        return Output()
    }
    
    deinit {
        print("[info] deinited IntroViewModel")
    }
}
