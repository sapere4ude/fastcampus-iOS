//
//  ViewController.swift
//  MyNetflix
//
//  Created by sapere4ude on 2020/12/09.
//  Copyright © 2020 com.sapere4ude. All rights reserved.
//

import UIKit

class AppTabbarController: UITabBarController {
    
   override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
