//
//  MemberDAO.swift
//  Voyage Voyage
//
//  Created by DSI on 23/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ParticipantsDAO{
    static let request : NSFetchRequest<Participant> = Participant.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(travel: Participant){
        CoreDataManager.context.delete(travel)
    }
    
    static func fetchAll() -> [Participant]?{
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
    
    static func search(forName firstname: String)->[Participant]?{
        self.request.predicate = NSPredicate(format: "firstname == #@", firstname)
        do{
            return try CoreDataManager.context.fetch(request) as [Participant]
        }
        catch{
            return nil
        }
    }
    
    static func search(forTravel travel: Travel)->[Participant]?{
        return travel.contient?.allObjects as? [Participant]
    }
}