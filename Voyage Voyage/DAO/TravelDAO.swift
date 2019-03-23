//
//  TravelDAO.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData

class TravelDAO{
    static let request : NSFetchRequest<Travel> = Travel.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(travel: Travel){
        CoreDataManager.context.delete(travel)
    }
    
    static func fetchAll() -> [Travel]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
    /// number of elements
    static var count: Int{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forTitle title: String)->[Travel]?{
        self.request.predicate = NSPredicate(format: "travelName == #@", title)
        do{
            return try CoreDataManager.context.fetch(request) as [Travel]
        }
        catch{
            return nil
        }
    }
    
}
