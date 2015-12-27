//
//  ObservableCollection.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class ObservableCollection<T>: NSObject, CollectionChangedProtocol {
    
    private lazy var collection: [T] = [T]()
    
    var collectionChanged: ((CollectionChangedAction, index: Int) -> Void)?
    
    var count: Int {
        return collection.count
    }
    
    override init() {
        super.init()
        
        
    }
    
    func append(item: T)
    {
        collection.append(item)
        
        let index = collection.count - 1
        notifyCollectionChanged(CollectionChangedAction.CollectionChangedActionAdd, index: index)
    }
    
    func removeAtIndex(index: Int)
    {
        if (index < 0)
        {
            return
        }
        
        collection.removeAtIndex(index)
        
        notifyCollectionChanged(CollectionChangedAction.CollectionChangedActionDelete, index: index)
    }
    
    func notifyCollectionChanged(action: CollectionChangedAction, index: Int)
    {
        collectionChanged?(action, index: index)
        
        print("\(action): \(index)")
    }
    
    subscript(index: Int) -> T
    {
        return collection[index]
    }
}
