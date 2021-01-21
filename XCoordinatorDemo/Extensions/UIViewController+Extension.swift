//
//  UIViewController+Extension.swift
//  247Phim
//
//  Created by Hoang Do on 8/7/20.
//  Copyright © 2020 SSGroup. All rights reserved.
//

import UIKit
import XCoordinator

extension UIViewController {
    
    func appDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    var firstPresentingViewController : UIViewController {
        get {
            
            var presentingController: UIViewController? = self
            while (presentingController?.presentingViewController != nil){
                presentingController = presentingController?.presentingViewController
            }
            
            return presentingController!
        }
    }
    
    func setRightBarButton(_ image: UIImage,
                           _ selector: Selector,
                           tag: Int = 0) {
        let rightButtonBar = UIBarButtonItem(image: image,
                                             style: .plain,
                                             target: self,
                                             action: selector)
        rightButtonBar.tag = tag
        self.navigationItem.rightBarButtonItems = [rightButtonBar]
    }
    
    func setLeftBarButton(_ image: UIImage,
                          _ selector: Selector,
                          tag: Int = 0) {
        let leftButtonBar = UIBarButtonItem(image: image,
                                            style: .plain,
                                            target: self,
                                            action: selector)
        leftButtonBar.tag = tag
        self.navigationItem.leftBarButtonItems = [leftButtonBar]
    }
    
    public var isVisible: Bool {
        if isViewLoaded {
            return view.window != nil
        }
        return false
    }
    
    /// Instantiate view controller
    /// - Parameter StoryboardName: Storyboard Identifier
    /// - Returns: the view controller type
    static func instantiate(storyboardName: StoryboardName) -> Self {
        return UIStoryboard.instantiateStoryboard(type: self, name: storyboardName)
    }
}

extension Presentable {
    func setWindowX(_ window: UIWindow) {
        func setWindow() {
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
        
        if let _ = window.rootViewController?.presentedViewController {
            window.rootViewController?.dismiss(animated: false, completion: {
                setWindow()
            })
        } else {
            setWindow()
        }
    }
}
