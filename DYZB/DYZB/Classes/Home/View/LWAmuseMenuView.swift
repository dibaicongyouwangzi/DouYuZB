//
//  LWAmuseMenuView.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/11.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWAmuseMenuView: UIView {
    
}

extension LWAmuseMenuView {
    class func amuseMenuView() -> LWAmuseMenuView {
        return Bundle.main.loadNibNamed("LWAmuseMenuView", owner: nil, options: nil)?.first as! LWAmuseMenuView
    }
}
