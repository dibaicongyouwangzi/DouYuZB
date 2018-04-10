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
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90
 
private let kGameCellID = "kGameCellID"
private let kGameHeaderViewID = "kGameHeaderViewID"

class LWGameViewController: UIViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var gameView : LWRecommendGameView = {
        let gameView = LWRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    fileprivate lazy var topHeaderView : LWCollectionHeaderView = {
        let headerView = LWCollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named : "Img_orange")
        headerView.titleLabel.text = "常见"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    fileprivate lazy var gameVM : LWGameViewModel = LWGameViewModel()
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgeMargin, 0, kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.contentInset = UIEdgeInsetsMake(kHeaderViewH + kGameViewH, 0, 0, 0)
        collectionView.autoresizesSubviews = false
        collectionView.register(UINib(nibName: "LWCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "LWCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeaderViewID)
        
        return collectionView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
    }
}
 
 // MARK:- 请求数据
 extension LWGameViewController {
    fileprivate func loadData() {
        // 1.展示“全部”游戏
        gameVM.loadAllGameModel {
            self.collectionView.reloadData()
            // 2.展示”常用“游戏
            self.gameView.games = Array(self.gameVM.games[0..<10])
        }
    }
 }
 
// MARK:- 设置UI界面
extension LWGameViewController {
    fileprivate func setupUI() {
        // 1.添加UICollectionView
        view.addSubview(collectionView)
        // 2.添加顶部的headerView
        collectionView.addSubview(topHeaderView)
        // 3.将常用游戏的view添加到collectionView中
        collectionView.addSubview(gameView)
    }
}
 
// MARK:- 遵守UICollectionView的数据源代理
 extension LWGameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! LWCollectionGameCell
        
        cell.game = gameVM.games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGameHeaderViewID, for: indexPath) as! LWCollectionHeaderView
        
        // 2.给headerView设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named : "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
 }
