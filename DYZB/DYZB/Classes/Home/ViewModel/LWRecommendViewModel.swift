//
//  LWRecommendViewModel.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/4.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWRecommendViewModel {
    // MARK:- 懒加载属性
    private lazy var anchorGroups : [LWAnchorGroupModel] = [LWAnchorGroupModel]()
}

// MARK:- 发送网络请求
extension LWRecommendViewModel {
    func requestData() {
        // 1.请求第一部分的推荐数据
        
        // 2.请求第二部分的颜值数据
        
        // 3.请求后面部分的游戏数据
        /*
         接口地址：http://capi.douyucdn.cn/api/v1/getHotCate
         请求参数：time    获取当前时间的字符串
                 limit   获取数据的个数
                 offset  偏移的数据量
         http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1522857088
         */
        LWNetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            // 2.根据data这个key，获取数组
            guard let dataArr =  resultDict["data"] as? [[String : NSObject]] else {return}
            
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArr {
                guard let dictArr = dict["room_list"] as? [[String : NSObject]] else {return}
                for dic in dictArr {
                    print(dic["nickname"] ?? "")
                }
                print("--------")
            }
        }
    }
}
