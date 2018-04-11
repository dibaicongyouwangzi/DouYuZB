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
    
}

extension LWFunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        collectionView.contentInset = UIEdgeInsetsMake(kTopMargin, 0, 0, 0)
    }
}
