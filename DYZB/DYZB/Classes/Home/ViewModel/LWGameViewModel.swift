//
//  LWGameViewModel.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/10.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWGameViewModel {
    lazy var games : [LWGameModel] = [LWGameModel]()
}

extension LWGameViewModel {
    func loadAllGameModel(finishedCallback : @escaping () -> ()) {
        LWNetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail") { (result) in
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            // 2.字典转模型
            for dict in dataArray {
                self.games.append(LWGameModel(dict : dict))
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
