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
                
                var viewModel = newValue as? NotifyPropertyChangedProtocol
                
                if viewModel != nil
                {
                    viewModel?.propertyChanged = updateViewFromViewModel
                }
                
            }
        }
    }
    
    func updateViewFromViewModel(propertyName: String)
    {
        print("UpdateView: \(propertyName)")
    }
    
}
