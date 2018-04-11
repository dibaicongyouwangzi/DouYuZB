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
    func loadAnchorData(URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        LWNetworkTools.requestData(type: .GET, URLString: URLString, parameters: parameters) { (result) in
            // 1.对结果进行处理
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArr = resultDict["data"] as? [[String : Any]] else {return}
            
            // 2.字典转模型
            for dict in dataArr {
                self.anchorGroups.append(LWAnchorGroupModel(dict: dict))
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}

