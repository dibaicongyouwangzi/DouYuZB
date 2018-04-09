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
    lazy var anchorGroups : [LWAnchorGroupModel] = [LWAnchorGroupModel]()
    private lazy var bigDataGroup : LWAnchorGroupModel = LWAnchorGroupModel()
    private lazy var prettyGroup : LWAnchorGroupModel = LWAnchorGroupModel()
    
    lazy var cycleModels : [LWCycleModel] = [LWCycleModel]()
}

// MARK:- 发送网络请求
extension LWRecommendViewModel {
    // 请求推荐数据
    func requestData(finishCallback : @escaping () -> ()) {
        // 0.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        // 0.5.创建dispatch_group
        let dGroup = DispatchGroup()
        
        /*
         1.请求第一部分的推荐数据
         接口地址：http://capi.douyucdn.cn/api/v1/getBigDataRoom
         请求参数：time    获取当前时间的字符串
         http://capi.douyucdn.cn/api/v1/getBigDataRoom?time=1522979247
         */
        dGroup.enter()
        LWNetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getBigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            // 2.根据data这个key，获取数组
            guard let dataArr =  resultDict["data"] as? [[String : NSObject]] else {return}
            
            // 3.遍历字典，并且转成模型对象
            // 3.1.创建组
            //            let group = LWAnchorGroupModel()
            // 3.2.设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            // 3.3.获取主播数据
            for dict in dataArr {
                let anchor = LWAnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            // 4.离开组
            dGroup.leave()
        }
        
        
        /*
         2.请求第二部分的颜值数据
         接口地址：http://capi.douyucdn.cn/api/v1/getVerticalRoom
         请求参数：time    获取当前时间的字符串
         limit   获取数据的个数
         offset  偏移的数据量
         http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1522857088
         */
        dGroup.enter()
        LWNetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            // 2.根据data这个key，获取数组
            guard let dataArr =  resultDict["data"] as? [[String : NSObject]] else {return}
            
            // 3.遍历字典，并且转成模型对象
            // 3.1 创建组
            //            let group = LWAnchorGroupModel()
            // 3.2 设置属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            // 3.3 获取主播数据
            for dict in dataArr {
                let anchor = LWAnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 4.离开组
            dGroup.leave()
        }
        
        
        /*
         3.请求2-12部分的游戏数据
         接口地址：http://capi.douyucdn.cn/api/v1/getHotCate
         请求参数：time    获取当前时间的字符串
         limit   获取数据的个数
         offset  偏移的数据量
         http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1522857088
         */
        dGroup.enter()
        LWNetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            // 2.根据data这个key，获取数组
            guard let dataArr =  resultDict["data"] as? [[String : NSObject]] else {return}
            
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArr {
                let group = LWAnchorGroupModel(dict: dict)
                self.anchorGroups.append(group)
            }
            // 4.离开组
            dGroup.leave()
        }
        
        // 4.所有的数据都请求到之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }

    // 请求无限轮播数据
    func requestCycleData(finishCallback : @escaping () -> ()) {
        /*
         接口地址：http://www.douyutv.com/api/v1/slide/6
         请求参数：version    当前版本号：2.300
         http://www.douyutv.com/api/v1/slide/6?version=2.300
         */
        LWNetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else {return}
            
            // 2.根据data的key获取数据
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else {return}
            
            // 3.字典转模型对象
            for dict in dataArr {
                 self.cycleModels.append(LWCycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
}
