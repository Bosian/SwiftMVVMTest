//
//  MainViewModel.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class MainViewModel: BaseViewModel
{
    var dataItems = ObservableCollection<MainCellViewModel>() {
        didSet {
            if (dataItems != oldValue) {
                notifyPropertyChanged()
            }
        }
    }
    
    override init() {

        let titleArray = ["OneTime Binding", "OneWay Binding With Converter", "TwoWay Binding"]
        
        let viewControllerArray =
        [
            NSStringFromClass(OneTimeViewController).componentsSeparatedByString(".").last,
            NSStringFromClass(OneWayViewController).componentsSeparatedByString(".").last,
            NSStringFromClass(TwoWayViewController).componentsSeparatedByString(".").last
        ]
        
        
        for var f = 0; f < titleArray.count; f++
        {
            let itemViewModel = MainCellViewModel()
            
            itemViewModel.titleText = titleArray[f]
            itemViewModel.navigation = viewControllerArray[f]
            
            self.dataItems.append(itemViewModel)
        }
        
        super.init()
    }

}
