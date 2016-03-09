//
//  MainTableViewCell.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2016/2/14.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class MainTableViewCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    private(set) var viewModel: MainCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    override func dataContextChanged(dataContext: NotifyPropertyChangedProtocol) {
        
        super.dataContextChanged(dataContext)
        
        viewModel = dataContext as! MainCellViewModel
    }

    
    // =============== View event ===============

    
}
