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
    // 定义主播的模型对象
    lazy var anchors : [LWAnchorModel] = [LWAnchorModel]()

    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        self.room_list = dict["room_list"] as? [[String : NSObject]] ?? []
        self.tag_name = dict["tag_name"] as? String ?? ""
        self.icon_name = dict["icon_name"] as? String ?? "home_header_normal"
        
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray {
                    anchors.append(LWAnchorModel(dict: dict))
                }
            }
        }
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
