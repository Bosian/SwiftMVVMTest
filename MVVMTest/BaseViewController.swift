//
//  BaseViewController.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BindableDelegate, UITextFieldDelegate {
    
    private var viewModel: BaseViewModel!
    
    var dataContext: NotifyPropertyChangedProtocol! {
        
        didSet {
            
            // 註冊ViewModel，屬性變更時通知
            if dataContext !== oldValue
            {
                guard let viewModel = dataContext as? BaseViewModel else {
                    return
                }
                
                viewModel.viewController = self
                viewModel.propertyChanged += PropertyChangeParameter(sender: self, method: { [unowned self] (viewModel, propertyName) -> Void in
                    self.updateViewFromViewModel(viewModel, propertyName)
                    })
                
                dataContextChanged(dataContext)
                updateAllView(dataContext)
            }
        }
    }
    
    /**
     * ViewDidLoad是否已被呼叫 (因為Base被呼叫ViewDidLoad時，ViewModel還是nil，用於之後補Call)
     */
    var isViewDidLoadBeCallWhenDataContextIsNil: Bool = false
    
    deinit {
        
        #if DEBUG
            
            print("deinit...\(self.dynamicType)")
            
        #endif
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        // 鍵盤
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
        // App進入背景或進入前景時觸發事件
        notificationCenter.removeObserver(self, name: UIApplicationWillEnterForegroundNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIApplicationDidEnterBackgroundNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        // App進入背景或進入前景時觸發事件
        notificationCenter.addObserver(self, selector: "viewWillAppear:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: "viewDidDisappear:", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
        // 鍵盤
        notificationCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        if let viewModel = viewModel
        {
            viewModel.viewDidLoad()
        }
        else
        {
            // 需補Call ViewDidLoad
            isViewDidLoadBeCallWhenDataContextIsNil = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        viewModel?.viewDidDisappear(animated)
        
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        viewModel?.didReceiveMemoryWarning()
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        
        return .Portrait
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return .Portrait
    }
    
    // === Update View ===
    
    func updateViewFromViewModel(dataContext: NotifyPropertyChangedProtocol, _ propertyName: String)
    {
        #if DEBUG
            let viewModelMirror = Mirror(reflecting: viewModel)
            
            print("UpdateView: \(self.dynamicType) << \(viewModelMirror.subjectType).\(propertyName)")
        #endif
        
        switch (propertyName)
        {
            case "isUpdate":
            
                // StatusBar上的網路圖示動畫
                UIApplication.sharedApplication().networkActivityIndicatorVisible = viewModel.isUpdate
                
                break
                
            default:
                break
                
        }
        
    }
    
    func dataContextChanged(dataContext: NotifyPropertyChangedProtocol) {
        viewModel = dataContext as! BaseViewModel
        
        // 是否需要補Call ViewDidLoad
        if isViewDidLoadBeCallWhenDataContextIsNil
        {
            viewModel?.viewDidLoad()
        }
    }
    
    func updateAllView(dataContext: NotifyPropertyChangedProtocol) {
        
        updateViewFromViewModel(dataContext, "isUpdate")
        
        let mirrorForViewModel = Mirror(reflecting: dataContext)
        
        // 更新ViewModel中對應到的View
        for (label, _) in mirrorForViewModel.children
        {
            updateViewFromViewModel(dataContext, label!)
        }
    }
    
    // ========== UITableView, UIPickerView ==========
    
    /**
    * ReloadView
    */
    func collectionChanged(view: UIView, action: CollectionChangedAction, index:Int)
    {
        if view is UITableView
        {
            collectionChangedForTableView(view as! UITableView, action: action, index: index)
        }else if view is UIPickerView {
            collectionChangedForPickerView(view as! UIPickerView, action: action, index: index)
        }
        
    }
    
    /**
     * ReloadUIPickerView
     */
    func collectionChangedForPickerView(pickerView: UIPickerView, action: CollectionChangedAction, index: Int)
    {
        pickerView.reloadAllComponents()
    }
    
    /**
     * 鍵盤將顯示
     */
    func keyboardWillShow(notification: NSNotification)
    {
        //        guard self.view.frame.origin.y >= 0 else {
        //            return
        //        }
        //
        //        guard let userInfo = notification.userInfo else {
        //            return
        //        }
        //
        //        guard let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() else {
        //            return
        //        }
        //
        //        UIView.animateWithDuration(0.5) { [unowned self] () -> Void in
        //
        //            self.view.center.y -= keyboardSize.size.height
        //        }
        //
        //        self.view.layoutIfNeeded()
    }
    
    /**
     * 鍵盤將隱藏
     */
    func keyboardWillHide(notification: NSNotification)
    {
        //        var frame = self.view.frame
        //        frame.origin.y = 0
        //
        //        UIView.animateWithDuration(1.0) { [unowned self] () -> Void in
        //
        //            self.view.frame = frame
        //        }
        //
        //        self.view.layoutIfNeeded()
    }
    
    /**
     * 新增移除TableViewCell
     */
    func collectionChangedForTableView(tableView: UITableView, action: CollectionChangedAction, index: Int)
    {
        tableView.beginUpdates()
        
        switch action
        {
        case .Add:
            
            tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
            
            break
            
        case .Delete:
            
            tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
            
            break
            
        case .Update:
            
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
            
            break
            
        }
        
        tableView.endUpdates()
    }
    
    // ========== UI Event ==========
    
    /**
     * 收鍵盤
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /**
     * 收鍵盤
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
}
