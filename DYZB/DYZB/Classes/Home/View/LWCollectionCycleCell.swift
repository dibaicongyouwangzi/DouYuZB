//
//  LWCollectionCycleCell.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/8.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit
import Kingfisher

class LWCollectionCycleCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:- 定义模型属性
    var cycleModel : LWCycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = NSURL(string : cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as URL), placeholder: UIImage(named : "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
