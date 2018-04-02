
//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/2.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        
        self.init(red : r / 255.0, green : g / 255.0, blue : b / 255.0, alpha : 1.0)
    }
}
