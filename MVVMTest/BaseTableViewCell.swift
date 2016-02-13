//
//  BaseTableViewCell.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/1/7.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, BindableDelegate, UITextFieldDelegate {
    
    private weak var viewModel: BaseBindable?
    
    weak var dataContext: AnyObject! {
        
        didSet {
            
            if dataContext !== oldValue
            {
                guard let viewModel = dataContext as? BaseBindable else
                {
                    return
                }
                
                viewModel.viewController = self
                viewModel.propertyChanged += PropertyChangeParameter(sender: self, method: updateViewFromViewModel)
                
                updateAllViewWhenDataContextChanged(dataContext)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // === Update View ===
    
    func updateViewFromViewModel(propertyName: String)
    {
        print("UpdateView: \(propertyName)")
        
        switch (propertyName)
        {
        case "isUpdate":
            
            let viewModel = dataContext as! BaseBindable
            
            // StatusBar上的網路圖示動畫
            UIApplication.sharedApplication().networkActivityIndicatorVisible = viewModel.isUpdate
            
            break
            
        default:
            break
            
        }
        
    }
    
    func updateAllViewWhenDataContextChanged(dataContext: AnyObject) {
        viewModel = dataContext as? BaseBindable
        
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
    
    /**
     * 收鍵盤
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
}
