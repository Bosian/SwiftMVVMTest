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
    
    private lazy var propertyChanged = [listener]()
    
    /**
     * 由於Swift 無法使用method type互相做比較，所以多傳入一個 instance進行比較
     */
    private lazy var instanceArray = [UIView?]()
    
    func append(parameter: CollectionChangeParameter)
    {
        let instance = parameter.view
        let receiver = parameter.receiver
        
        // 防止加入同一個instance
        guard instanceArray.indexOf({$0 === instance}) == nil else
        {
            return
        }
        
        instanceArray.append(instance)
        propertyChanged.append(receiver)
    }
    
    /**
     * 移除註冊
     * 由於Swift 無法使用method type互相做比較，所以多傳入一個 instance進行比較
     */
    func remove(parameter: CollectionChangeParameter)
    {
        let instance = parameter.view
        
        if let index = instanceArray.indexOf({ $0 === instance})
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
        for (f, method) in propertyChanged.enumerate()
        {
            guard let view = instanceArray[f] else {
                continue
            }
            
            method(view , action: action, index: index)
        }
    }
}

class CollectionChangeParameter : NSObject
{
    typealias listener = (UIView, action: CollectionChangedAction, index: Int) -> Void
    
    weak var view: UIView?
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
