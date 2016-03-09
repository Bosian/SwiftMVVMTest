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
    typealias listener = (NotifyPropertyChangedProtocol, String) -> Void
    
    weak var sender: NotifyPropertyChangedProtocol?
    
    private var propertyChanged = [listener]()
    
    /**
     * 由於Swift 無法使用method type互相做比較，所以多傳入一個 instance進行比較
     */
    private var instanceArray: [Weak<AnyObject>] = []
    
    init(sender: NotifyPropertyChangedProtocol?)
    {
        self.sender = sender
    }
    
    func append(parameter: PropertyChangeParameter)
    {
        weak var sender = parameter.sender
        let receiver = parameter.method
        
        // 防止加入同一個instance
        guard instanceArray.indexOf({$0.value === sender}) == nil else
        {
            return
        }
        
        instanceArray.append(Weak<AnyObject>(value: sender))
        propertyChanged.append(receiver)
    }
    
    /**
     * 移除註冊
     * 由於Swift 無法使用method type互相做比較，所以多傳入一個 instance進行比較
     */
    func remove(parameter: PropertyChangeParameter)
    {
        let sender = parameter.sender
        
        if let index = instanceArray.indexOf({ $0.value === sender})
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
        guard let sender = sender else {
            
            #if DEBUG
                print("\r\n\r\nsender是空的: \(self.dynamicType).propertyName")
            #endif
            
            return
        }
        
        removeIfEmpty()
        
        for method in propertyChanged
        {
            method(sender, propertyName)
        }
    }
    
    /**
     * 移除已被釋放的EventHandler
     */
    func removeIfEmpty()
    {
        if let index = instanceArray.indexOf({ $0.value == nil})
        {
            instanceArray.removeAtIndex(index)
            propertyChanged.removeRange(index...index)
        }
    }
    
}

/**
 * PropertyChange 所需的傳入參數
 */
class PropertyChangeParameter : NSObject {
    
    typealias listener = (NotifyPropertyChangedProtocol, String) -> Void
    
    weak var sender: AnyObject?
    var method: listener
    
    init(sender: AnyObject?, method: listener) {
        
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