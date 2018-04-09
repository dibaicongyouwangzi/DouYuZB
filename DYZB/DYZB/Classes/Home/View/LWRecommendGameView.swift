//
//  LWRecommendGameView.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/9.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class LWRecommendGameView: UIView {
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
    }
}

// MARK:- 提供快速创建的类方法
extension LWRecommendGameView {
    class func recommendGameView() -> LWRecommendGameView {
        return Bundle.main.loadNibNamed("LWRecommendGameView", owner: nil, options: nil)?.first as! LWRecommendGameView
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension LWRecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.blue : UIColor.red
        return cell
    }
}
