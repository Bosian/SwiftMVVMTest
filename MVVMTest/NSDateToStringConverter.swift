//
//  NSDateToStringConverter.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/2/14.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class NSDateToStringConverter: NSObject, ValueConverterProtocol {
    
    /**
     * ViewModel to View
     */
    func convert(value: AnyObject?, parameter: AnyObject?) -> AnyObject?
    {
        var dateString = ""
        
        if let date = value as? NSDate
        {
            let dateFormater = NSDateFormatter()
            
            dateFormater.locale = NSLocale.currentLocale()
            dateFormater.dateFormat = parameter as! String
            
            dateString = dateFormater.stringFromDate(date)
        }
        
        return dateString
    }
    
    /**
     * View to ViewModel
     */
    func backConvert(value: AnyObject?, parameter: AnyObject?) -> AnyObject?
    {
        var date: NSDate? = nil
        
        if let dateString = value as? String
        {
            let dateFormater = NSDateFormatter()
            
            dateFormater.locale = NSLocale.currentLocale()
            dateFormater.dateFormat = parameter as! String
            
            date = dateFormater.dateFromString(dateString)
        }
        
        return date
    }
}
