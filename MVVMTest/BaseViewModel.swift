//
//  BaseViewModel.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import Foundation

class BaseViewModel: NSObject, NotifyPropertyChangedProtocol {

    var propertyChanged: ((String) -> Void)?
    
    func notifyPropertyChanged(propertyName: String) {
        
        propertyChanged?(propertyName)
    }
    
}
