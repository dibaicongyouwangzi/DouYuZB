//
//  LWFunnyViewModel.swift
//  DYZB
//
//  Created by 迪拜葱油王子 on 2018/4/11.
//  Copyright © 2018年 迪拜葱油王子. All rights reserved.
//

import UIKit

class LWFunnyViewModel : LWBaseViewModel {

}

extension LWFunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/2", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
