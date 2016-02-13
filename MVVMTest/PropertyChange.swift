//
//  PropertyChanged.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/1/12.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

/**
 * 給View註冊屬性變更
 */
class PropertyChange
{
    typealias listener = (String) -> Void
    
    private lazy var propertyChanged = [listener]()
    
    /**
     * 由於Swift 無法使用method type互相做比較，所以多傳入一個 instance進行比較
     */
    private lazy var instanceArray = [Weak<AnyObject>]()
    
    func append(parameter: PropertyChangeParameter)
    {
        let instance = parameter.sender
        let receiver = parameter.method
        
        // 防止加入同一個instance
        guard instanceArray.indexOf({$0 === instance}) == nil else
        {
            return
        }
        
        instanceArray.append(Weak<AnyObject>(value: instance))
        propertyChanged.append(receiver)
    }
    
    /**
     * 移除註冊
     * 由於Swift 無法使用method type互相做比較，所以多傳入一個 instance進行比較
     */
    func remove(parameter: PropertyChangeParameter)
    {
        let instance = parameter.sender
        
        if let index = instanceArray.indexOf({ $0 === instance})
        {
            instanceArray.removeAtIndex(index)
            propertyChanged.removeRange(index...index)
        }
    }
    
    /**
     * 通知所有註冊的View
     */
    func invoke(propertyName: String)
    {
        for method in propertyChanged
        {
            method(propertyName)
        }
    }
}

/**
 * PropertyChange 所需的傳入參數
 */
class PropertyChangeParameter : NSObject {
    
    typealias listener = (String) -> Void
    
    weak var sender: AnyObject?
    var method: listener
    
    init(sender: AnyObject, method: listener) {
        
        self.sender = sender
        self.method = method
        
        super.init()
    }
}

/**
 * 使用 += 註冊 PropertyChanged 事件
 */
func += (inout left: PropertyChange, right: PropertyChangeParameter)
{
    
    left.append(right)
}

/**
 * 使用 -= 取消註冊 PropertyChanged 事件
 */
func -= (inout left: PropertyChange, right: PropertyChangeParameter)
{
    left.remove(right)
}