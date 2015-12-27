//
//  BaseViewController.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var dataContext: AnyObject! {
        
        willSet {
            
            if (dataContext !== newValue)
            {
                self.dataContext = newValue
                
                if var viewModel = newValue as? NotifyPropertyChangedProtocol
                {
                    viewModel.propertyChanged = updateViewFromViewModel
                }

                updateAllViewWhenDataContextChanged()
            }
        }
    }
    
    func updateViewFromViewModel(propertyName: String)
    {
        print("UpdateView: \(propertyName)")
    }
    
    func updateAllViewWhenDataContextChanged()
    {
    
    }
    
}
