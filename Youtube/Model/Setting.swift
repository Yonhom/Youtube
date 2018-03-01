//
//  Setting.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/3/1.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import Foundation

class Setting {
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    var name: SettingName?
    var imageName: String?
}
