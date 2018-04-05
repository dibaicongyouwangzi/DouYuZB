//
//  LWAnchorGroupModel.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/5.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWAnchorGroupModel: NSObject {
    // 该组中对应的房间信息
    var room_list : [[String : NSObject]]?
    // 组显示的标题
    var tag_name : String = ""
    // 组显示的图标
    var icon_name : String = "home_header_normal"
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
