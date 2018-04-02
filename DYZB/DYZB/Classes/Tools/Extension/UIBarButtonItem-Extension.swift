//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/2.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    // 遍历构造函数：1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }

        self.init(customView: btn)
    }
}
