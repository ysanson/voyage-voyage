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
        CoreDataManager.context.delete(participant)
    }
    static func update(forParticipant participant: Participant, newFirstName fName: String, newLastName lName: String, newEntryDate entDate: Date){
        participant.firstname = fName
        participant.lastname = lName
        participant.entrydate = entDate
        save()
    }
    static func setGone(forParticipant participant: Participant){
        participant.exitdate = Date.init()
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
    
    static func search(forFullname fullname: String, forTravel travel: Travel)->Participant?{
        guard let parts = travel.contient?.allObjects as? [Participant] else {return nil}
        for part in parts{
            if part.fullname == fullname{
                return part
            }
        }
        return nil
    }
    
    static func searchForStillHere(forTravel travel: Travel)->[Participant]?{
        guard let parts = ParticipantsDAO.search(forTravel: travel) else { return nil }
        var result: [Participant] = []
        for part in parts{
            if part.exitdate == nil{
                result.append(part)
            }
        }
        return result
    }
    
}
