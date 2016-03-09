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
    
    override func updateViewFromViewModel(dataContext: NotifyPropertyChangedProtocol, _ propertyName: String)
    {
        super.updateViewFromViewModel(dataContext, propertyName)
        
        switch propertyName
        {
            case "dataItems":
                
                viewModel.dataItems.collectionChanged += CollectionChangeParameter(view: self.tableView, method: { [unowned self] (view, action, index) -> Void in
                    self.collectionChanged(view, action: action, index: index)
                })
                
                tableView.reloadData()
            
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
        
        viewModel = dataContext as! MainViewModel
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

