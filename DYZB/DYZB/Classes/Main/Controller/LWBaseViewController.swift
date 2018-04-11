//
//  LWBaseViewController.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/11.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWBaseViewController: UIViewController {
    
    // MARK:- 定义属性
    var contentView : UIView?

    // MARK:- 懒加载属性
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let animImageView = UIImageView(image : UIImage(named : "img_loading_1"))
        animImageView.center = self.view.center
        animImageView.animationImages = [UIImage(named : "img_loading_1")!, UIImage(named : "img_loading_2")!]
        animImageView.animationDuration = 0.5
        animImageView.animationRepeatCount = LONG_MAX // LONG_MAX表示一个非常大的Int值
        animImageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin] // 让顶部、底部随着父控件的拉伸而拉伸
        return animImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension LWBaseViewController {
    @objc func setupUI() {
        // 0.隐藏内容的view
        contentView?.isHidden = true
        
        // 1.添加执行动画的UIImageView
        view.addSubview(animImageView)
        
        // 2.给animImageView执行动画
        animImageView.startAnimating()
        
        // 3.设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }

    func loadDataFinished() {
        // 1.停止动画
        animImageView.stopAnimating()
        
        // 2.隐藏animImageView
        animImageView.isHidden = true
        
        // 3.显示内容的view
        contentView?.isHidden = false
    }
}
