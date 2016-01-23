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
    func converter(value: AnyObject?, parameter: AnyObject?) -> AnyObject?
    
    /**
     * View to ViewModel
     */
    func backConverter(value: AnyObject?, parameter: AnyObject?) -> AnyObject?
}
