//
//  NotifyPropertyChangedProtocol.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import Foundation

protocol NotifyPropertyChangedProtocol
{
    var propertyChanged: ((String) -> Void)? { get set }
    
    func notifyPropertyChanged(propertyName: String)
}