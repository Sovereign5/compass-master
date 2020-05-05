//
//  LocationView.swift
//  compass
//
//  Created by Mac Cooper on 5/5/20.
//  Copyright © 2020 Mac Cooper. All rights reserved.
//

//import Foundation
import UIKit
@IBDesignable class LocationView: BaseView {

    @IBOutlet weak var  allowButton: UIButton!
    @IBOutlet weak var  denyButton: UIButton!
    var didTapAllow: (()-> Void)?
    
    @IBAction func allowAction(_ sender: UIButton){
       // didTapAllow?()
        print("hello!")
    }
    
    @IBAction func denyAction(_ sender: UIButton){
           
       }

}
