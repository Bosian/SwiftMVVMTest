//
//  ViewController.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
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
            default:
                break
        }
    }

    // =============== View event ===============
    
    @IBAction func buttonHandler(sender: UIButton) {
        
        viewModel.buttonHandler(sender)

    }
    
    @IBAction func textFieldChanged(sender: UITextField) {
     
        viewModel.text = sender.text
    }
}

