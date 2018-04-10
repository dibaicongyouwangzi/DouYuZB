//
//  LWGameModel.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/10.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWGameModel: NSObject {
    // MARK:- 定义属性
    var tag_name : String = ""
    var pic_url : String = ""
    
    // MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        self.tag_name = dict["tag_name"] as? String ?? ""
        self.pic_url = dict["pic_url"] as? String ?? ""
        
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
