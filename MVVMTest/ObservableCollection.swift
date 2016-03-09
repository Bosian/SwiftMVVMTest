//
//  ObservableCollection.swift
//  MVVMTest
//
//  Created by 劉柏賢 on 2015/12/27.
//  Copyright © 2015年 劉柏賢. All rights reserved.
//

import UIKit

class ObservableCollection<T>: NSObject, CollectionChangedProtocol {
    
    private(set) var collection: [T] = [T]()
    
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
        guard 0 <= index && index < collection.count else
        {
            return
        }
        
        collection.removeAtIndex(index)
        
        notifyCollectionChanged(CollectionChangedAction.Delete, index: index)
    }
    
    func removeAll()
    {
        let count = collection.count
        
        for var f = count - 1; f >= 0; f--
        {
            removeAtIndex(f)
        }
    }
    
    func notifyCollectionChanged(action: CollectionChangedAction, index: Int)
    {
        #if DEBUG
            print("\(self.dynamicType): \(action): \(index)")
        #endif
        
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
    