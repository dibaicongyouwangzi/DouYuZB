//
//  LWCollectionHeaderView.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/3.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWCollectionHeaderView: UICollectionReusableView {

    // MARK:- 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    // MARK:- 模型属性
    var group : LWAnchorGroupModel? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named : group?.icon_name ?? "home_header_normal")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }    
}
