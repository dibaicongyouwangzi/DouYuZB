//
//  LWCustomNavigationController.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/12.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWCustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 要隐藏要push的控制器的tabBar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}

