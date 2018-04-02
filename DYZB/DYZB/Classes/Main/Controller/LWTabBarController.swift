//
//  LWTabBarController.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/2.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc(sbName: "Home")
        addChildVc(sbName: "Live")
        addChildVc(sbName: "Follow")
        addChildVc(sbName: "Profile")
    }
    
    private func addChildVc(sbName : String) {
        // 1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: sbName, bundle: nil).instantiateInitialViewController()!
        
        // 2.将childVc作为子控制器
        addChildViewController(childVc)
    }
}
