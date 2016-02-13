//
//  Weak.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/2/14.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class Weak<T : AnyObject>: NSObject {

    weak var value: T?
    
    init(value: T?) {
        self.value = value
    }
    
}
