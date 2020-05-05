//
//  BaseView.swift
//  compass
//
//  Created by Mac Cooper on 5/5/20.
//  Copyright © 2020 Mac Cooper. All rights reserved.
//

//import Foundation
import UIKit

@IBDesignable class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }

    func configure() {

    }
}
