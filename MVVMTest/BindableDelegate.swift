//
//  CollectionChangedProtocol.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

protocol BindableDelegate {
    
    var dataContext: AnyObject! { get set }
    
    func updateViewFromViewModel(propertyName: String)
    
    func updateAllViewWhenDataContextChanged(dataContext: AnyObject)
}