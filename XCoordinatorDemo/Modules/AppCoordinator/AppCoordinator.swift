//
//  AppCoordinator.swift
//  XCoordinatorDemo
//
//  Created by Van Tien Tu on 22/01/2021.
//

import UIKit
import XCoordinator
import RxSwift

enum AppRouter: Route {
    case main
    case intro
    case dismiss
}

class AppCoordinator: ViewCoordinator<AppRouter> {
    
    let bag = DisposeBag()
    private var mainRouter: StrongRouter<TabbarRouter>!
    
    init() {
        super.init(rootViewController: UIViewController(), initialRoute: .intro)
    }
    
    override func prepareTransition(for route: AppRouter) -> ViewTransition {
        switch route {
        case .intro:
            let vc = IntroViewController()
            
            let viewModel = IntroViewModel()
            
            viewModel.viewDidAppear
                .flatMap { [weak self] (_) -> Observable<Void> in
                    guard let self = self else {
                        return .just(())
                    }
                    return self.rx.trigger(.main)
                }
                .subscribe()
                .disposed(by: self.bag)
            
            vc.viewModel = viewModel
            return .present(vc)
        case .main:
             self.mainRouter = XTabbarCoordinator().strongRouter
             self.mainRouter.setWindowX(UIApplication.shared.windows.first!)
            return .present(self.mainRouter)
        case .dismiss:
            return .dismiss()
        }
    }
}

extension Transition {
    
    static func presentFullScreen(_ presentable: Presentable, animation: Animation? = nil) -> Transition {
        presentable.viewController?.modalPresentationStyle = .fullScreen
        return .present(presentable, animation: animation)
    }

    static func dismissAll() -> Transition {
        return Transition(presentables: [], animationInUse: nil) { rootViewController, options, completion in
            guard let presentedViewController = rootViewController.presentedViewController else {
                completion?()
                return
            }
            presentedViewController.dismiss(animated: options.animated) {
                Transition.dismissAll()
                    .perform(on: rootViewController, with: options, completion: completion)
            }
        }
    }
}
