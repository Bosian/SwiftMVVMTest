//
//  TwoWayViewController.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/2/14.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class OneTimeViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    private(set) var viewModel: OneTimeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataContext = OneTimeViewModel()
    }
    
    
    // =============== Update Binding ===============
    
    override func updateViewFromViewModel(dataContext: NotifyPropertyChangedProtocol, _ propertyName: String)
    {
        super.updateViewFromViewModel(dataContext, propertyName)
        
        switch propertyName
        {
            case "titleText":
                titleLabel.text = viewModel.titleText
                
            default:
                break
        }
    }
    
    /**
     * When DataContext Changed then update all View
     */
    override func dataContextChanged(dataContext: NotifyPropertyChangedProtocol)
    {
        super.dataContextChanged(dataContext)
        
        viewModel = dataContext as! OneTimeViewModel
    }

}
