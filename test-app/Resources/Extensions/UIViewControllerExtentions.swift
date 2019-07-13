//
//  UIViewControllerExtentions.swift
//  test-app
//
//  Created by maxim mironov on 05/05/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//

import UIKit
extension UIViewController{
    /**
     Just return the initial vc on a storyboard
     */
    static func getInstance() -> UIViewController{
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
}
