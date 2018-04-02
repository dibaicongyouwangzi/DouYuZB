 //
//  LWPageContentView.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/2.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"
 
class LWPageContentView: UIView {

    // MARK:- 定义属性
    private var childVcs : [UIViewController]
    private var parentVc : UIViewController
    
    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0; // 行间距
        layout.minimumInteritemSpacing = 0; // item间距
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    // MARK:- 自定义构造函数
    init(frame : CGRect, childVcs : [UIViewController], parentVc : UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        
        super.init(frame : frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
// MARK:- 设置UI界面
extension LWPageContentView {
    private func setupUI() {
        // 1.将所有的子控制器添加到父控制器中
        for childVc in childVcs {
            parentVc.addChildViewController(childVc)
        }
        
        // 2.添加UICollectionView，用于在Cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
}
 
// MARK:- 遵守UICollectionViewDataSource
extension LWPageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        // 2.给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}
