//
//  OneTimeViewModel.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/2/14.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class OneWayViewModel: BaseViewModel {

    var timer: NSTimer?
    
    var date: NSDate? {
        didSet {
            if date != oldValue {
                notifyPropertyChanged()
            }
        }
    }
    
    var titleText: String? = "This is a one way binding." {
        didSet {
            if titleText != oldValue {
                notifyPropertyChanged()
            }
        }
    }
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        timer?.invalidate()
    }
    
    deinit {
        print("deinit")
    }
    
    func startButtonHandler()
    {
        guard timer == nil else {
            return
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerTick", userInfo: nil, repeats: true)
    }
    
    func timerTick()
    {
        date = NSDate()
    }
}
