//
//  LWHomeViewController.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/2.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class LWHomeViewController: UIViewController {

    // MARK:- 懒加载属性
    private lazy var pageTitleView : LWPageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = LWPageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        
        return titleView
    }()
    
    private lazy var pageContentView : LWPageContentView = { [weak self] in
        // 1.确定内容的frame
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH)
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(LWRecommendViewController())
        childVcs.append(LWGameViewController())
        childVcs.append(LWAmuseViewController())
        childVcs.append(LWFunnyViewController())
        let contentView = LWPageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 设置UI界面
        setupUI()
    }
}

// MARK:- 设置UI界面
extension LWHomeViewController {
    private func setupUI() {
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加titleView
        view.addSubview(pageTitleView)
        
        // 3.添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setupNavigationBar() {
        // 1.设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.设置右侧的item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}

// MARK:- 遵守LWPageTitleViewDelegate协议
extension LWHomeViewController : LWPageTitleViewDelegate {
    func pageTitleView(titleView: LWPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// MARK:- 遵守LWPageContentViewDelegate协议
extension LWHomeViewController : LWPageContentViewDelegate {
    func pageContentView(contentView: LWPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitle(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
