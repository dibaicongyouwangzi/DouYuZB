//
//  LWFunnyViewController.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/11.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class LWFunnyViewController: LWBaseAnchorViewController {
    // MARK:- 懒加载ViewModel对象
    fileprivate lazy var funnyVM : LWFunnyViewModel = LWFunnyViewModel()
}

extension LWFunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        collectionView.contentInset = UIEdgeInsetsMake(kTopMargin, 0, 0, 0)
    }
}

extension LWFunnyViewController {
    override func loadData() {
        // 1.给父类中的ViewModel进行赋值
        baseVM = funnyVM
        
        // 2.请求数据
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
        }
    }
}
