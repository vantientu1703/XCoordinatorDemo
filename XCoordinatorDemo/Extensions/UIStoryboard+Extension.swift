//
//  UIStoryboard+Extension.swift
//  VOD
//
//  Created by Hoang Son on 3/9/20.
//  Copyright © 2020 SSGroup. All rights reserved.
//

import UIKit

enum StoryboardName: String{
    case Main
    
    var filename: String {
        return rawValue.capitalized
    }
}

extension UIStoryboard {
    
    static func instantiateStoryboard<T>(type: T.Type, name: StoryboardName) -> T where T: UIViewController {
        let bundle = Bundle(for: T.self)
        let storyboard = UIStoryboard(name: name.filename, bundle: bundle)
        guard let controller = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            return T()
        }
        return controller
    }
    
    static func initWithStoryboard<T: UIViewController>(name: StoryboardName) -> T? {
        let viewController = UIStoryboard(name: name.filename, bundle: nil)
                                .instantiateViewController(withIdentifier: String(describing: T.self)) as? T
        return viewController;
    }
}

extension NSObject {
    var identifierString: String {
        return String(describing: self)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
}

