//
//  SecondCoordinator.swift
//  XCoordinatorDemo
//
//  Created by Van Tien Tu on 21/01/2021.
//

import UIKit
import XCoordinator
import RxSwift

enum SecondRouter: Route {
    case second
    case dismiss
    case present
}

class SecondCoordinator: NavigationCoordinator<SecondRouter> {
    
    let bag = DisposeBag()
    
    init() {
        print("[info] inited SecondCoordinator")
        super.init(rootViewController: UINavigationController(), initialRoute: .second)
    }
    
    override func prepareTransition(for route: SecondRouter) -> NavigationTransition {
        switch route {
        case .second:
            let vc = SecondViewController.instantiate(storyboardName: .Main)
            vc.modalPresentationStyle = .fullScreen
            
            let viewModel = SecondViewModel()
            
            viewModel.dismissTriggered
                .flatMap { [weak self] (_) -> Observable<Void> in
                    guard let self = self else {
                        return .just(())
                    }
                    return self.rx.trigger(.dismiss)
                }
                .subscribe()
                .disposed(by: self.bag)
            
            viewModel.presentTriggered
                .flatMap { [weak self] (_) -> Observable<Void> in
                    guard let self = self else {
                        return .just(())
                    }
                    return self.rx.trigger(.present)
                }
                .subscribe()
                .disposed(by: self.bag)
            
            vc.viewModel = viewModel
            return .set([vc])
        case .present:
            let router = MainCoordinator().strongRouter
            return .present(router)
        case .dismiss:
            return .dismiss()
        }
    }
    
    deinit {
        print("[info] deinited SecondCoordinator")
    }
}
