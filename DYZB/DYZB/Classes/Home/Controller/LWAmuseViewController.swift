//
//  LWAmuseViewController.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/10.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWAmuseViewController: LWBaseAnchorViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var amuseVM : LWAmuseViewModel = LWAmuseViewModel()
}

// MARK:- 请求数据
extension LWAmuseViewController {
    override func loadData() {
        // 1.给父类中的ViewModel进行赋值
        baseVM = amuseVM
        
        // 2.请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}