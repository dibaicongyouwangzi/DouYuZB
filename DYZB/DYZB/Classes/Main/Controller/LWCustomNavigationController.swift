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
        
        // 1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else {return}
        
        // 2.获取手势添加到的view中
        guard let gesView = systemGes.view else {return}
        
        // 3.获取target/action
        // 3.1利用运行时机制查看所有的属性名称
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {return}
        // 3.2取出target
        guard let target = targetObjc.value(forKey: "target") else {return}
        // 3.3取出action
//        guard let action = targetObjc.value(forKey: "action") as? Selector else {return}
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        panGes.addTarget(target, action: action)
        gesView.addGestureRecognizer(panGes)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 要隐藏要push的控制器的tabBar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}

