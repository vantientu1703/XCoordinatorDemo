//
//  MainCoordinator.swift
//  XCoordinatorDemo
//
//  Created by Van Tien Tu on 21/01/2021.
//

import UIKit
import XCoordinator
import RxSwift

enum MainRouter: Route {
    case main
    case second
    case push
    case pop
}

class MainCoordinator: NavigationCoordinator<MainRouter> {
    let bag = DisposeBag()
    
    init() {
        print("[info] inited MainCoordinator")
        super.init(rootViewController: UINavigationController(), initialRoute: .main)
    }
    
    override func prepareTransition(for route: MainRouter) -> NavigationTransition {
        switch route {
        case .main:
            let vc = ViewController.instantiate(storyboardName: .Main)
            let viewModel = MainViewModel()
            
            viewModel.presentTriggered
                .flatMap { [weak self] (_) -> Observable<Void> in
                    guard let self = self else {
                        return .just(())
                    }
                    return self.rx.trigger(.second)
                }
                .subscribe()
                .disposed(by: self.bag)
            viewModel.pushTriggered
                .flatMap { [weak self] (_) -> Observable<Void> in
                    guard let self = self else {
                        return .just(())
                    }
                    return self.rx.trigger(.push)
                }
                .subscribe()
                .disposed(by: self.bag)
            
            vc.viewModel = viewModel
            return .set([vc])
        case .second:
            let router = SecondCoordinator().strongRouter
            return .presentFullScreen(router)
        case .push:
            let vc = SecondViewController.instantiate(storyboardName: .Main)
            
            let viewModel = SecondViewModel()
            
            viewModel.dismissTriggered
                .flatMap { [weak self] (_) -> Observable<Void> in
                    guard let self = self else {
                        return .just(())
                    }
                    return self.rx.trigger(.pop)
                }
                .subscribe()
                .disposed(by: self.bag)
            
            vc.viewModel = viewModel
            return .push(vc)
        case .pop:
            return .pop()
        }
    }
    
    deinit {
        print("[info] deinited MainCoordinator")
    }
}
