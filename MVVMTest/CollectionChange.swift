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
    typealias listener = (UITableView, action: CollectionChangedAction, index: Int) -> Void
    
    private lazy var propertyChanged = [listener]()
    
    /**
     * 由於Swift 無法使用method type互相做比較，所以多傳入一個 instance進行比較
     */
    private lazy var instanceArray = [UITableView]()
    
    func append(instance: UITableView, method receiver: listener)
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
    func invoke(action: CollectionChangedAction, index: Int)
    {
        for (f, method) in propertyChanged.enumerate()
        {
            method(instanceArray[f] , action: action, index: index)
        }
    }
}