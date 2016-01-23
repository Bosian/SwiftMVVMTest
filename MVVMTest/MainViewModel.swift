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
                notifyPropertyChanged()
            }
        }
     }
    
    var dataItems: ObservableCollection<String> {
        
        didSet {
            
            if (dataItems != oldValue)
            {
                notifyPropertyChanged()
            }
        }
    }
    
    override init() {

        self.dataItems = ObservableCollection<String>()

        for var f = 0; f < 10; f++
        {
            self.dataItems.append(String(f))
        }
        
        super.init()
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
    
    func addItemHandler(sender: UIButton!)
    {
        let count = dataItems.count
        
        self.dataItems.append(String(count))
    }
    
    func removeItemHandler(sender: UIButton!)
    {
        let index = dataItems.count - 1
        
        self.dataItems.removeAtIndex(index)
    }
}
