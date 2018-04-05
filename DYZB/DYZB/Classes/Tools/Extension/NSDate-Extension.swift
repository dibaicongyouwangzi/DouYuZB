
//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/4.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
