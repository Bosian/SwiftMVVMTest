//
//  ViewController.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    private(set) var viewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataContext = MainViewModel()
    }

    // =============== Update Binding ===============
    
    override func updateViewFromViewModel(propertyName: String)
    {
        super.updateViewFromViewModel(propertyName)
        
        switch propertyName
        {
            case "dataItems":
                
                viewModel.dataItems.collectionChanged.append(CollectionChangeParameter(view: self.tableView, method: collectionChanged))
                
                break
            default:
                break
        }
    }
    
    /**
     * When DataContext Changed then update all View
     */
    override func updateAllViewWhenDataContextChanged(dataContext: AnyObject) {
        
        super.updateAllViewWhenDataContextChanged(dataContext)
        
        viewModel = dataContext as! MainViewModel
        
        let mirror = Mirror(reflecting: viewModel)
        
        // 更新ViewModel中對應到的View
        for (label, _) in mirror.children
        {
            updateViewFromViewModel(label!)
        }
    }
    
    // =============== TableView ===============
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.dataItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BaseTableViewCell
        
        cell.dataContext = viewModel.dataItems[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let cellViewModel = viewModel.dataItems[indexPath.row]
        
        guard let navigation = cellViewModel.navigation else {
            return
        }
        
        self.performSegueWithIdentifier(navigation, sender: nil)
    }
    
}

