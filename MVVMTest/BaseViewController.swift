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
        
        willSet {
            
            // 註冊ViewModel，屬性變更時通知
            if (dataContext !== newValue)
            {
                self.dataContext = newValue
                
                if let viewModel = newValue as? BaseViewModel
                {
                    viewModel.viewController = self
                    viewModel.propertyChanged += updateViewFromViewModel
                }
                
                updateAllViewWhenDataContextChanged(dataContext)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDidLoad()
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
        super.viewDidDisappear(animated)
        
        viewModel?.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        viewModel?.didReceiveMemoryWarning()
    }
    
    // === Update View ===
    
    func updateViewFromViewModel(propertyName: String)
    {
        print("UpdateView: \(propertyName)")
        
        switch (propertyName)
        {
        case "isUpdate":
            
            // StatusBar上的網路圖示動畫
            let viewModel = dataContext as! BaseViewModel
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
    
    /**
     * 新增移除TableViewCell
     */
    func collectionChanged(tableView: UITableView, action: CollectionChangedAction, index: Int)
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
}