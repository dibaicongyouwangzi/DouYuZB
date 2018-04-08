//
//  LWAnchorModel.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/5.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWAnchorModel: NSObject {
    // 房间ID
    var room_id : Int = 0
    // 房间图片对应的URLString
    var vertical_src : String = ""
    // 判断是手机直播还是电脑直播(0 : 电脑直播，1 : 手机直播)
    var isVertical : Int = 0
    // 房间名称
    var room_name : String = ""
    // 主播昵称
    var nickname : String = ""
    // 观看人数
    var online : Int = 0
    // 所在城市
    var anchor_city : String = ""
    
    init(dict : [String : NSObject]) {
        self.room_id = dict["room_id"] as? Int ?? 0
        self.vertical_src = dict["vertical_src"] as? String ?? ""
        self.isVertical = dict["isVertical"] as? Int ?? 0
        self.room_name = dict["room_name"] as? String ?? ""
        self.nickname = dict["nickname"] as? String ?? ""
        self.online = dict["online"] as? Int ?? 0
        self.anchor_city = dict["anchor_city"] as? String ?? ""
        
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
