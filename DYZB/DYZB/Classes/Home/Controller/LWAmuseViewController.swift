//
//  LWAmuseViewController.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/10.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class LWAmuseViewController: LWBaseAnchorViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var amuseVM : LWAmuseViewModel = LWAmuseViewModel()
    
    fileprivate lazy var menuView : LWAmuseMenuView = {
        let menuView = LWAmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
}

// MARK:- 设置UI界面
extension LWAmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        // 将菜单的view添加到控制器的view中
        collectionView.addSubview(menuView)
        
        collectionView.contentInset = UIEdgeInsetsMake(kMenuViewH, 0, 0, 0)
    }
}

// MARK:- 请求数据
extension LWAmuseViewController {
    override func loadData() {
        // 1.给父类中的ViewModel进行赋值
        baseVM = amuseVM
        
        // 2.请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
        }
    }
}
