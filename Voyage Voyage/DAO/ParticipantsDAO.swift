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
    static func delete(participant: Participant){
        participant.exitdate = Date.init()
    }
    static func update(forParticipant participant: Participant, newFirstName fName: String, newLastName lName: String, newEntryDate entDate: Date){
        participant.firstname = fName
        participant.lastname = lName
        participant.entrydate = entDate
        save()
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
    
    static func totalPayement(forParticipant participant: Participant)->Float{
        var amount = 0.0
        
        return Float(amount)
    }
    
    static func totalAmount(forParticipant participant: Participant)->Float{
        var amount = 0.0
        
        
        return Float(amount)
    }
    
}
