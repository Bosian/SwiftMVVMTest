//
//  BaseBindable.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class BaseBindable: NSObject, NotifyPropertyChangedProtocol {
    
    /**
     * 是否正在更新
     */
    var isUpdate: Bool = false {
        didSet {
            if (isUpdate != oldValue) {
                notifyPropertyChanged()
            }
        }
    }
    
    /**
     * viewController
     */
    weak var viewController: AnyObject?
    
    var propertyChanged = PropertyChange()
    
    func notifyPropertyChanged(propertyName: String = __FUNCTION__) {
        
        propertyChanged.invoke(propertyName)
    }
    
}
