//
//  CollectionChangedProtocol.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

protocol BindableDelegate {
    
    var dataContext: NotifyPropertyChangedProtocol! { get set }
    
    func updateViewFromViewModel(dataContext: NotifyPropertyChangedProtocol, _ propertyName: String)
    
    func dataContextChanged(dataContext: NotifyPropertyChangedProtocol)
    
    func updateAllView(dataContext: NotifyPropertyChangedProtocol)
    
    func collectionChanged(view: UIView, action: CollectionChangedAction, index:Int)
}