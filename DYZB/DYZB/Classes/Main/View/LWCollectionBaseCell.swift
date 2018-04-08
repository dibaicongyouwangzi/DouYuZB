//
//  LWCollectionBaseCell.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/8.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit
import Kingfisher

class LWCollectionBaseCell: UICollectionViewCell {
    // MARK:- 控件的属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!

    // MARK:- 定义模型
    var anchor : LWAnchorModel? {
        didSet {
            // 0.校验模型是否有值
            guard let anchor = anchor else {return}
            
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if arc4random_uniform(5000000) >= 10000 {
                onlineStr = "\(Int(arc4random_uniform(5000000) / 10000))万在线"
            } else {
                onlineStr = "\(arc4random_uniform(5000000))在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            // 3.设置封面图片
            guard let iconURL = NSURL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as URL))
        }
    }
}
