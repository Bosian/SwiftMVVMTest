//
//  IValueConverter.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/1/18.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

protocol ValueConverterProtocol {

    /**
     * ViewModel to View
     */
    func convert(value: AnyObject?, parameter: AnyObject?) -> AnyObject?
    
    /**
     * View to ViewModel
     */
    func backConvert(value: AnyObject?, parameter: AnyObject?) -> AnyObject?
    
}