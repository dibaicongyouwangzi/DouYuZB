//
//  LWRecommendViewController.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/3.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class LWRecommendViewController: LWBaseAnchorViewController {

    // MARK:- 懒加载属性
    private lazy var recommendVM : LWRecommendViewModel = LWRecommendViewModel()
    
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
    }
}

// MARK:- 设置UI界面内容
extension LWRecommendViewController {
    override func setupUI() {
        // 1.先调用super
        super.setupUI()
        
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
    override func loadData() {
        // 0.给父类中的ViewModel进行赋值
        baseVM = recommendVM
        
        // 1.请求推荐数据
        recommendVM.requestData { [weak self] in
            // 1.1.展示推荐数据
            self?.collectionView.reloadData()
            // 1.2.将数据传递给LWRecommendGameView
            self?.gameView.groups = self?.recommendVM.anchorGroups
        }
        
        // 2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

// MARK:- 遵守UICollectionView的UICollectionViewDelegateFlowLayout协议
extension LWRecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 { // 颜值组
                // 1.取出prettyCell
                let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! LWPrettyCell
               
                // 2.设置数据
                prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
                
                return prettyCell
            } else { // 普通组
                return super.collectionView(collectionView, cellForItemAt: indexPath)
            }
    }
    
    // 决定了indexPath这个位置item的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 { // 颜值组
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}

