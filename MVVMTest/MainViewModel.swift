//
//  MainViewModel.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class MainViewModel: BaseViewModel{
    
    var text: String! {
        
        didSet {
            
            if (oldValue != text)
            {
                notifyPropertyChanged("text")
            }
        }
    }
    
    func getDate() -> String!
    {
        let date = NSDate()
        let dateFormater = NSDateFormatter()
        dateFormater.locale = NSLocale.currentLocale()
        dateFormater.dateFormat = "yyyy/MM/dd hh:mm:ss"
        
        return dateFormater.stringFromDate(date)
    }

    // =============== View event =============== 
    
    func buttonHandler(sender: UIButton) {
        
        text = getDate()
    }
}
