//
//  NotifyPropertyChangedProtocol.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

protocol NotifyPropertyChangedProtocol: class
{
    /**
     * 給View註冊屬性變更
     */
    var propertyChanged: PropertyChange { get set }
    
    /**
     * 通知View，屬性變更
     */
    func notifyPropertyChanged(propertyName: String)
}