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
    private lazy var instanceArray = [AnyObject]()
    
    func append(instance: AnyObject, method receiver: listener)
    {
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
    func remove(instance: AnyObject, method: listener)
    {
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
 * 使用 += 註冊 PropertyChanged 事件
 */
func += (inout left: PropertyChange, right: ((String) -> Void))
{
    
    left.append(left as AnyObject, method: right)
}

/**
 * 使用 -= 取消註冊 PropertyChanged 事件
 */
func -= (inout left: PropertyChange, right: ((String) -> Void))
{
    left.remove(left, method: right)
}