//
//  BaseViewModel.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject, NotifyPropertyChangedProtocol {
    
    /**
     * 是否正在更新
     */
    var isUpdate: Bool = false {
        didSet {
            if (isUpdate != oldValue) {
                notifyPropertyChanged()
            }
        }
    }
    
    /**
     * viewController
     */
    weak var viewController: UIViewController!
    
    /**
     * 給View註冊屬性變更
     */
    var propertyChanged = PropertyChange(sender: nil)
    
    /**
     * 通知View，屬性變更
     */
    func notifyPropertyChanged(propertyName: String = __FUNCTION__) {
        
        propertyChanged.invoke(propertyName)
    }
    
    // === ViewController Event ===
    
    override init() {
        
        #if DEBUG
            
            print("init...\(self.dynamicType)")
            
        #endif
        
        super.init()
        
        propertyChanged.sender = self
    }
    
    
    deinit {
        
        #if DEBUG
            
            print("deinit...\(self.dynamicType)")
            
        #endif
    }
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear(animated: Bool) {
        
    }
    
    func viewDidAppear(animated: Bool) {
        
    }
    
    func viewDidDisappear(animated: Bool) {
        
    }
    
    func didReceiveMemoryWarning() {
        
    }
    
}
