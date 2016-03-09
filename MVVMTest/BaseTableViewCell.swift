//
//  BaseTableViewCell.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/1/7.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, BindableDelegate, UITextFieldDelegate {
    
    private var viewModel: BaseBindable!
    weak var pageViewController: BaseViewController!
    weak var tableView: UITableView!
    
    var dataContext: NotifyPropertyChangedProtocol! {
        
        didSet {
            
            if dataContext !== oldValue
            {
                guard let viewModel = dataContext as? BaseBindable else
                {
                    return
                }
                
                self.tableView = self.superview?.superview as! UITableView
                self.pageViewController = self.tableView.delegate as! BaseViewController
                viewModel.viewController = self
                viewModel.propertyChanged += PropertyChangeParameter(sender: self, method: { [weak self] (viewModel, propertyName) -> Void in
                    self?.updateViewFromViewModel(viewModel, propertyName)
                })
                
                dataContextChanged(dataContext)
                updateAllView(dataContext)
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        #if DEBUG
            print("init...style:reuseIdentifier: \(self.dynamicType)")
        #endif
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        #if DEBUGK
            print("init...coder:\(self.dynamicType)")
        #endif
        
        super.init(coder: aDecoder)
    }
    
    deinit {
        
        #if DEBUG
            
            print("deinit...\(self.dynamicType)")
            
        #endif
        
        ignoreFrameChanges()
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
                
                guard let viewModel = dataContext as? BaseViewModel else {
                    return
                }
                
                // StatusBar上的網路圖示動畫
                UIApplication.sharedApplication().networkActivityIndicatorVisible = viewModel.isUpdate
                
            default:
                break
            
        }
        
    }
    
    func dataContextChanged(dataContext: NotifyPropertyChangedProtocol) {
        viewModel = dataContext as! BaseBindable
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
    
    func watchFrameChanges()
    {
        addObserver(self, forKeyPath: "frame", options: .Initial, context: nil)
    }
    
    func ignoreFrameChanges()
    {
        if (self.observationInfo != nil )
        {
            removeObserver(self, forKeyPath: "frame")
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
    }
    
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
