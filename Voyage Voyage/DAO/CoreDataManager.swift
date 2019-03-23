//
//  CoreDataManager.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager{
    //context manager
    static let context: NSManagedObjectContext={
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("no context")
            exit(EXIT_FAILURE)
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    //return entity description from context
    
    class func entity(forName name: String) -> NSEntityDescription{
        guard let entity=NSEntityDescription.entity(forEntityName: name, in: self.context) else{
            fatalError("get entity \(name) description failed")
        }
        return entity
    }
    
    @discardableResult
    /// save all data
    ///
    /// - Returns: NSError or nil if save successes
    class func save() -> NSError?{
        // try to save it
        do{
            try CoreDataManager.context.save()
            return nil
        }
        catch let error as NSError{
            return error
        }
    }
}
