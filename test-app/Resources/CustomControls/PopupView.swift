//
//  PopupView.swift
//  test-app
//
//  Created by maxim mironov on 05/05/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//

import UIKit

class PopupUIView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
        
        backgroundColor = UIColor.white
    }
    
}
