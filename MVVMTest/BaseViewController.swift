//
//  BaseViewController.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BindableDelegate, UITextFieldDelegate {
    
    private var viewModel: BaseViewModel?
    
    var dataContext: AnyObject! {
        
        didSet {
            
            // 註冊ViewModel，屬性變更時通知
            if dataContext !== oldValue
            {
                guard let viewModel = dataContext as? BaseViewModel else {
                    return
                }
                
                viewModel.viewController = self
                viewModel.propertyChanged += PropertyChangeParameter(sender: self, method: updateViewFromViewModel)
                updateAllViewWhenDataContextChanged(dataContext)
            }
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // App進入背景或進入前景時觸發事件
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "viewWillAppear:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "viewDidDisappear:", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModel = viewModel
        {
            viewModel.propertyChanged += PropertyChangeParameter(sender: self, method: updateViewFromViewModel)
            viewModel.viewWillAppear(animated)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        if let viewModel = viewModel
        {
            viewModel.propertyChanged -= PropertyChangeParameter(sender: self, method: updateViewFromViewModel)
            viewModel.viewDidDisappear(animated)
        }
        
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
    
    func updateViewFromViewModel(propertyName: String)
    {
        print("UpdateView: \(propertyName)")
        
        switch (propertyName)
        {
        case "isUpdate":
            
            let viewModel = dataContext as! BaseViewModel
            
            // StatusBar上的網路圖示動畫
            UIApplication.sharedApplication().networkActivityIndicatorVisible = viewModel.isUpdate
            
            break
            
        default:
            break
            
        }
        
    }
    
    func updateAllViewWhenDataContextChanged(dataContext: AnyObject) {
        viewModel = dataContext as? BaseViewModel
        
        updateViewFromViewModel("isUpdate")
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
    
    /**
     * 回首頁
     */
    @IBAction func homeHandler(sender: UIBarButtonItem)
    {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
