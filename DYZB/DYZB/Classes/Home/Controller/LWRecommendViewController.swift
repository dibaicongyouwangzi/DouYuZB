//
//  LWRecommendViewController.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/3.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class LWRecommendViewController: UIViewController {

    // MARK:- 懒加载属性
    private lazy var recommendVM : LWRecommendViewModel = LWRecommendViewModel()
    
    private lazy var collectionView : UICollectionView = { [unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0 // 行间距
        layout.minimumInteritemSpacing = kItemMargin // item之间的间距
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName: "LWNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "LWPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "LWCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.autoresizesSubviews = false
        return collectionView
    }()
    
    private lazy var cycleView : LWRecommendCycleView = {
        let cycleView = LWRecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView : LWRecommendGameView = {
        let gameView = LWRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.brown
        
        // 设置UI界面
        setupUI()
        
        // 发送网络请求
        loadData()
    }
}

// MARK:- 设置UI界面内容
extension LWRecommendViewController {
    private func setupUI() {
        // 1.将UICollectionView添加到控制器的view中
        view.addSubview(collectionView)
        
        // 2.将cycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        // 3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    
        // 4.将gameView添加到collectionView中
        collectionView.addSubview(gameView)
    }
}

// MARK:- 请求数据
extension LWRecommendViewController {
    private func loadData() {
        // 1.请求推荐数据
        recommendVM.requestData { [weak self] in
            self?.collectionView.reloadData()
        }
        
        // 2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension LWRecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 0.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        // 1.定义cell
        var cell : LWCollectionBaseCell!
        
        // 2.取出cell
        if indexPath.section == 1 { // 颜值组
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! LWPrettyCell
        } else { // 普通组
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! LWNormalCell
        }
        
        // 3.将模型赋值给cell
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出sectionHeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! LWCollectionHeaderView
        
        // 2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    // 决定了indexPath这个位置item的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 { // 颜值组
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
