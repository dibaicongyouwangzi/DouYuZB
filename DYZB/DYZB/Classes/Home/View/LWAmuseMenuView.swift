//
//  LWAmuseMenuView.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/11.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class LWAmuseMenuView: UIView {
    
    // MARK:- 定义属性
    var groups : [LWAnchorGroupModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK:- 从xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "LWAmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

extension LWAmuseMenuView {
    class func amuseMenuView() -> LWAmuseMenuView {
        return Bundle.main.loadNibNamed("LWAmuseMenuView", owner: nil, options: nil)?.first as! LWAmuseMenuView
    }
}

extension LWAmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if groups == nil {
            return 0
        }
        
        // 计算页码的算法
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! LWAmuseMenuCell
        
        // 2.给cell设置数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellDataWithCell(cell : LWAmuseMenuCell, indexPath : IndexPath) {
        /*
         1.取出起始位置 & 终点位置
         // 0页：0 ~ 7
         // 1页：8 ~ 15
         // 2页：16 ~ 23
         */
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1 ) * 8 - 1
        
        // 2.判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        // 3.取出数据，并且赋值给cell
        cell.clipsToBounds = true
        cell.groups = Array(groups![startIndex...endIndex])
    }
}

extension LWAmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
