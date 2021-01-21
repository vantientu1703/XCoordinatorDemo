//
//  TabbarCoordinator.swift
//  XCoordinatorDemo
//
//  Created by Van Tien Tu on 21/01/2021.
//

import UIKit
import XCoordinator

enum TabbarRouter: Route {
    case main
    case second
}

class XTabbarCoordinator: TabBarCoordinator<TabbarRouter> {
    
    let mainRouter: StrongRouter<MainRouter>
    let secondRouter: StrongRouter<SecondRouter>
    
    init() {
        let main = MainCoordinator()
        let second = SecondCoordinator()
        self.mainRouter = main.strongRouter
        self.secondRouter = second.strongRouter
        
        main.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        second.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        super.init(tabs: [self.mainRouter, self.secondRouter], select: self.mainRouter)
    }
    
    override func prepareTransition(for route: TabbarRouter) -> TabBarTransition {
        switch route {
        case .main:
            return .select(self.mainRouter)
        case .second:
            return .select(self.secondRouter)
        }
    }
}
