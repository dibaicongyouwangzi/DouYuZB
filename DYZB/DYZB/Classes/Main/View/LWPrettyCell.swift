//
//  LWPrettyCell.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/4.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWPrettyCell: LWCollectionBaseCell {

    // MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK:- 定义模型属性
    override var anchor : LWAnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            
            // 3.所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
