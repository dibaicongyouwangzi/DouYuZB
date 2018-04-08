//
//  LWNormalCell.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/4.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWNormalCell: LWCollectionBaseCell {

    // MARK:- 控件的属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // MARK:- 定义模型属性
    override var anchor : LWAnchorModel? {
        didSet {
            super.anchor = anchor
            
            // 4.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
}
