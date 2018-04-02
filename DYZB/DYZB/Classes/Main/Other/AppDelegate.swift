//
//  AppDelegate.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/2.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }
}

