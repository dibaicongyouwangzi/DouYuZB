//
//  LWRecommendCycleView.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/8.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class LWRecommendCycleView: UIView {
    // MARK:- 定义属性
    var cycleModels : [LWCycleModel]? {
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
 
            // 2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    // MARK:- 控件属性 
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()

        // 注册cell
        collectionView.register(UINib(nibName: "LWCollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: kScreenW, height: kCycleViewH)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
    }
}

// MARK:- 提供一个快速创建view的类方法
extension LWRecommendCycleView {
    class func recommendCycleView() -> LWRecommendCycleView {
        return Bundle.main.loadNibNamed("LWRecommendCycleView", owner: nil, options: nil)?.first as! LWRecommendCycleView
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension LWRecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! LWCollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item]
        
        return cell
    }
}

// MARK:- 遵守UICollectionView的代理协议
extension LWRecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
    }
}
