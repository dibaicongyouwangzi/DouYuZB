 //
//  LWCycleModel.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/8.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWCycleModel: NSObject {
    // 标题
    var title : String = ""
    // 展示的图片地址
    var pic_url : String = ""
    // 主播信息对应的字典
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {return}
            anchor = LWAnchorModel(dict: room)
        }
    }
    
    // 主播信息对应的模型对象
    var anchor : LWAnchorModel?
    
    // MARK:- 自定义构造函数
    init(dict : [String : NSObject]) {
        self.title = dict["title"] as? String ?? ""
        self.pic_url = dict["pic_url"] as? String ?? ""
        self.room = dict["room"] as? [String : NSObject] ?? ["" : "" as NSObject]
        
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
