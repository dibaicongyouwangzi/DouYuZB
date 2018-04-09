//
//  LWRecommendGameView.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/9.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class LWRecommendGameView: UIView {
    // MARK:- 定义数据的属性
    var groups : [LWAnchorGroupModel]? {
        didSet {
            // 1.移除前两组数据(热门、颜值)
            groups?.removeFirst()
            groups?.removeFirst()
            
            // 1.5.添加更多组
            let moreGroup = LWAnchorGroupModel()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            // 2.刷新表格
            collectionView.reloadData()
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // 注册cell
        collectionView.register(UINib(nibName: "LWCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        // 给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMargin, 0, kEdgeInsetMargin)
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
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! LWCollectionGameCell
        
        cell.group = groups![indexPath.item]

        return cell
    }
}
