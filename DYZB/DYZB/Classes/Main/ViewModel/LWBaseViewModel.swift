//
//  LWBaseViewModel.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/10.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWBaseViewModel {
    // MARK:- 懒加载属性
    lazy var anchorGroups : [LWAnchorGroupModel] = [LWAnchorGroupModel]()
}

extension LWBaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        LWNetworkTools.requestData(type: .GET, URLString: URLString, parameters: parameters) { (result) in
            // 1.对结果进行处理
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArr = resultDict["data"] as? [[String : Any]] else {return}
            
            // 2.判断是否是分组数据
            if isGroupData {
                // 2.1字典转模型
                for dict in dataArr {
                    self.anchorGroups.append(LWAnchorGroupModel(dict: dict))
                }
            } else {
                // 2.1创建组
                let group = LWAnchorGroupModel()
                // 2.2遍历dataArr的所有字典
                for dict in dataArr {
                    group.anchors.append(LWAnchorModel(dict: dict))
                }
                // 2.3将group添加到anchorGroups中
                self.anchorGroups.append(group)
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}

