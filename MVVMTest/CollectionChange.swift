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
class CollectionChange
{
    typealias listener = (UIView, action: CollectionChangedAction, index: Int) -> Void
    
    private var propertyChanged = [listener]()
    
    /**
     * 由於Swift 無法使用method type互相做比較，所以多傳入一個 instance進行比較
     */
    private var instanceArray: [Weak<UIView>] = []
    
    func append(parameter: CollectionChangeParameter)
    {
        let sender = parameter.view
        let receiver = parameter.receiver
        
        // 防止加入同一個instance
        guard instanceArray.indexOf({$0.value === sender}) == nil else
        {
            return
        }
        
        instanceArray.append(Weak<UIView>(value: sender))
        propertyChanged.append(receiver)
    }
    
    /**
     * 移除註冊
     * 由於Swift 無法使用method type互相做比較，所以多傳入一個 instance進行比較
     */
    func remove(parameter: CollectionChangeParameter)
    {
        let sender = parameter.view
        
        if let index = instanceArray.indexOf({ $0.value === sender})
        {
            instanceArray.removeAtIndex(index)
            propertyChanged.removeRange(index...index)
        }
    }
    
    /**
     * 通知所有註冊的View
     */
    func invoke(action: CollectionChangedAction, index: Int)
    {
        removeIfEmpty()
        
        for (f, method) in propertyChanged.enumerate()
        {
            guard let view = instanceArray[f].value else {
                continue
            }
            
            method( view, action: action, index: index)
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

class CollectionChangeParameter : NSObject
{
    typealias listener = (UIView, action: CollectionChangedAction, index: Int) -> Void
    
    var view: UIView
    var receiver: listener
    
    init(view: UIView, method receiver: listener) {
        
        self.view = view
        self.receiver = receiver
        
        super.init()
    }
}

func += (inout left: CollectionChange, right: CollectionChangeParameter)
{
    left.append(right)
}

func -= (inout left: CollectionChange, right: CollectionChangeParameter)
{
    left.remove(right)
}
