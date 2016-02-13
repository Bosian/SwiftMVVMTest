//
//  OneTimeViewModel.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/2/14.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class TwoWayViewModel: BaseViewModel {

    var titleText: String? = "This is a two way binding." {
        didSet {
            if titleText != oldValue {
                notifyPropertyChanged()
            }
        }
    }
    
    var isTextFocus: Bool = true {
        didSet {
            if isTextFocus != oldValue {
                notifyPropertyChanged()
            }
        }
    }

}
