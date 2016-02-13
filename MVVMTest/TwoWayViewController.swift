//
//  TwoWayViewController.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/2/14.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class TwoWayViewController: BaseViewController {

    // === UI ===
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // === ViewModel ===
    private(set) var viewModel: TwoWayViewModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dataContext = TwoWayViewModel()
    }
    
    
    // =============== Update Binding ===============
    
    override func updateViewFromViewModel(propertyName: String)
    {
        super.updateViewFromViewModel(propertyName)
        
        switch propertyName
        {
            case "titleText":
                titleLabel.text = viewModel.titleText
            
            case "isTextFocus":
                textField.becomeFirstResponder()
            
            default:
                break
        }
    }
    
    /**
     * When DataContext Changed then update all View
     */
    override func updateAllViewWhenDataContextChanged(dataContext: AnyObject) {
        
        super.updateAllViewWhenDataContextChanged(dataContext)
        
        viewModel = dataContext as! TwoWayViewModel
        
        let mirror = Mirror(reflecting: viewModel)
        
        // 更新ViewModel中對應到的View
        for (label, _) in mirror.children
        {
            updateViewFromViewModel(label!)
        }
    }
    
    
    // =============== View event ===============
    
    @IBAction func textHandler(sender: UITextField) {
        
        viewModel.titleText = sender.text
    }
    
}
