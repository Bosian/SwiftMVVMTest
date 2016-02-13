//
//  MainCellViewModel.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/2/14.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class MainCellViewModel: BaseBindable {

    var titleText: String? {
        didSet {
            if titleText != oldValue {
                notifyPropertyChanged()
            }
        }
    }
    
    var navigation: String? {
        didSet {
            if navigation != oldValue {
                notifyPropertyChanged()
            }
        }
    }
}
