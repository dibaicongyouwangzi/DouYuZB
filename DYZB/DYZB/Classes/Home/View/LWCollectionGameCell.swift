//
//  LWCollectionGameCell.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/9.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit
import Kingfisher

class LWCollectionGameCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:- 定义模型属性
    var group : LWAnchorGroupModel? {
        didSet {
            titleLabel.text = group?.tag_name
            
            let iconURL = NSURL(string : group?.icon_url ?? "")!
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as URL), placeholder: UIImage(named : "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    var game : LWGameModel? {
        didSet {
            titleLabel.text = game?.tag_name
            
            let iconURL = NSURL(string : game?.pic_url ?? "")!
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as URL), placeholder: UIImage(named : "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
