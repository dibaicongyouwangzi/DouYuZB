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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! LWAmuseMenuCell
        
        // 2.给cell设置数据
        cell.backgroundColor = UIColor.getRandomColor()
        
        return cell
    }
}
