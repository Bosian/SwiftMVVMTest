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
    
    var collectionChanged = CollectionChange()
    
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
        notifyCollectionChanged(CollectionChangedAction.Add, index: index)
    }
    
    func removeAtIndex(index: Int)
    {
        if (index < 0)
        {
            return
        }
        
        collection.removeAtIndex(index)
        
        notifyCollectionChanged(CollectionChangedAction.Delete, index: index)
    }
    
    func notifyCollectionChanged(action: CollectionChangedAction, index: Int)
    {
        print("\(action): \(index)")
        
        collectionChanged.invoke(action, index: index)
    }
    
    subscript(index: Int) -> T
    {
        get {
            return collection[index]
        }
        
        set {
            
            collection[index] = newValue
            
            notifyCollectionChanged(CollectionChangedAction.Update, index: index)
        }
    }
    
}