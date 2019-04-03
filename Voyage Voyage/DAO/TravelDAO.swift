//
//  TravelDAO.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData
import UIKit

///This class represents the DAO used for the travels.
class TravelDAO{
    
    static let request : NSFetchRequest<Travel> = Travel.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(travel: Travel){
        CoreDataManager.context.delete(travel)
    }
    static func update(travel: Travel, newName name:String, newImage image: UIImage){
        travel.travelName = name
        travel.travelPhoto = image.jpegData(compressionQuality: 0.8)
        save()
    }
    
    ///Returns all the Travel elements in the database.
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
    
    ///Searches for the travels with the name in parameter.
    /// - Parameter title: the title of the travel.
    /// - Returns: A list of travels or nil.
    static func search(forTitle title: String)->[Travel]?{
        self.request.predicate = NSPredicate(format: "travelName == #@", title)
        do{
            return try CoreDataManager.context.fetch(request) as [Travel]
        }
        catch{
            return nil
        }
    }
    
    /**
     Adds people to the travel.
     - Parameters:
     - travel: the travel to add people to.
     - participant: the person to add to the travel.
 
    */
    static func addPeople(forTravel travel: Travel, participant: Participant){
        travel.addToContient(participant)
        save()
    }
    
}
