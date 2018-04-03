 //
//  LWPageContentView.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/2.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit
 
 protocol LWPageContentViewDelegate : class {
    func pageContentView(contentView : LWPageContentView, progress: CGFloat, sourceIndex : Int, targetIndex : Int)
 }

private let ContentCellID = "ContentCellID"
 
class LWPageContentView: UIView {

    // MARK:- 定义属性
    private var childVcs : [UIViewController]
    private weak var parentVc : UIViewController?
    private var startOffsetX : CGFloat = 0
    weak var delegate : LWPageContentViewDelegate?
    private var isForbidScrollDelegate : Bool = false // 默认是不禁止滚动
    
    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = { [weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0; // 行间距
        layout.minimumInteritemSpacing = 0; // item间距
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    // MARK:- 自定义构造函数
    init(frame : CGRect, childVcs : [UIViewController], parentVc : UIViewController?) {
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
            parentVc?.addChildViewController(childVc)
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
 
// MARK:- 遵守UICollectionViewDelegate
extension LWPageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate {return}
        
        // 1.定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        if currentOffsetX > startOffsetX { // 左滑
            // 2.1计算progress
            let ratio = currentOffsetX / scrollView.bounds.width
            progress = ratio - floor(ratio)
            
            // 2.2计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollView.bounds.width)
            
            // 2.3计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 2.4如果完全滑过去
            if currentOffsetX - startOffsetX == scrollView.bounds.width {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 2.1计算progress
            let ratio = currentOffsetX / scrollView.bounds.width
            progress = 1 - (ratio - floor(ratio))
            
            // 2.2计算targetIndex
            targetIndex = Int(currentOffsetX / scrollView.bounds.width)
            
            // 2.3计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        // 3.将progress、sourceIndex、targetIndex传递给LWPageTitleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
 
// MARK:- 对外暴露的方法
extension LWPageContentView {
    func setCurrentIndex(currentIndex : Int) {
        
        // 1.记录需要禁止执行代理方法
        isForbidScrollDelegate = true
        
        // 2.滚到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x : offsetX, y : 0), animated: false)
    }
}
