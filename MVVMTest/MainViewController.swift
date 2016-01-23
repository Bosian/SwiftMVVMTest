//
//  ViewController.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var tableView: UITableView!

    lazy var viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dataContext = viewModel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // =============== Update Binding ===============
    
    override func updateViewFromViewModel(propertyName: String)
    {
        super.updateViewFromViewModel(propertyName)
        
        switch propertyName
        {
            case "text":
                self.textField.text = viewModel.text
                self.textField2.text = viewModel.text
                break
            case "dataItems":
                
                viewModel.dataItems.collectionChanged.append(self.tableView, method: collectionChanged)
                
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
    
    /**
     * Update TableView
     */
    func collectionChanged(action: CollectionChangedAction, index: Int)
    {
        print("TableView Changed: \(index)")
        
        tableView.reloadData()
    }

    // =============== View event ===============
    
    @IBAction func buttonHandler(sender: UIButton) {
        
        viewModel.buttonHandler(sender)

    }
    
    @IBAction func addItemHandler(sender: UIButton) {
        
        viewModel.addItemHandler(sender)
    }
    
    @IBAction func removeItemHandler(sender: UIButton) {
        
        viewModel.removeItemHandler(sender)
    }
    
    
    @IBAction func textFieldChanged(sender: UITextField) {
     
        viewModel.text = sender.text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.dataItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = viewModel.dataItems[indexPath.row]
        
        return cell
    }
}

