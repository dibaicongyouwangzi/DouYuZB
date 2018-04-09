 //
//  LWGameViewController.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/9.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
 
private let kGameCellID = "kGameCellID"

class LWGameViewController: UIViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgeMargin, 0, kEdgeMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "LWCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}
 
// MARK:- 设置UI界面
extension LWGameViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}
 
// MARK:- 遵守UICollectionView的数据源代理
 extension LWGameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! LWCollectionGameCell
        
        cell.backgroundColor = UIColor.getRandomColor()
        
        return cell
    }
 }
