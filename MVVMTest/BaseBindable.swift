//
//  BaseBindable.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class BaseBindable: NSObject, NotifyPropertyChangedProtocol {
    
    weak var viewController: AnyObject?
    
    var propertyChanged = PropertyChange(sender: nil)
    
    var isUpdate: Bool = false {
        didSet {
            if (isUpdate != oldValue) {
                notifyPropertyChanged()
            }
        }
    }
    
    override init() {
        
        #if DEBUG
            
            print("init...\(self.dynamicType)")
            
        #endif
        
        super.init()
        
        propertyChanged.sender = self
    }
    
    deinit {
        
        #if DEBUG
            
            print("deinit...\(self.dynamicType)")
            
        #endif
    }
    
    func notifyPropertyChanged(propertyName: String = __FUNCTION__) {
        
        propertyChanged.invoke(propertyName)
    }
    
}
