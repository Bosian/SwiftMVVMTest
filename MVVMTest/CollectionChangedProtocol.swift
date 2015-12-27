//
//  CollectionChangedProtocol.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

protocol CollectionChangedProtocol {
    
    var collectionChanged: ((CollectionChangedAction, index: Int) -> Void)? { get set }
    
    func notifyCollectionChanged(action: CollectionChangedAction, index: Int)
}

enum CollectionChangedAction {
    case CollectionChangedActionAdd
    case CollectionChangedActionDelete
}