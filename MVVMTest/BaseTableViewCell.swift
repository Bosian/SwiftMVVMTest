//
//  BaseTableViewCell.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/1/7.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, BindableDelegate, UITextFieldDelegate {
    
    private var viewModel: BaseBindable?

    var dataContext: AnyObject! {
        
        willSet {
            
            if (dataContext !== newValue)
            {
                self.dataContext = newValue
                
                if var viewModel = newValue as? NotifyPropertyChangedProtocol
                {
                    viewModel.propertyChanged += updateViewFromViewModel
                }
                
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
                
                // StatusBar上的網路圖示動畫
                let viewModel = dataContext as! BaseBindable
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
    
    /**
     * 收鍵盤
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }


}
