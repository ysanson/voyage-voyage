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
    
    ///Sets the participant's exit date to the current one.
    /// - Parameter participant: the participant to set as gone.
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
    
    ///Searches for a participant with a specific firstname.
    ///- Parameter firstname: the firstname to search with.
    ///- Returns: an array of participants with the said name, or nil.
    static func search(forName firstname: String)->[Participant]?{
        self.request.predicate = NSPredicate(format: "firstname == #@", firstname)
        do{
            return try CoreDataManager.context.fetch(request) as [Participant]
        }
        catch{
            return nil
        }
    }
    
    ///Searches for the participants of a specific travel.
    ///- Parameter travel: the travel to search with.
    ///- Returns: an array of participants, or nil if there isn't.
    static func search(forTravel travel: Travel)->[Participant]?{
        return travel.contient?.allObjects as? [Participant]
    }
    
    ///Searches for a participant with a specific fullname.
    ///- Parameter fullname: the fullname to search with.
    ///- Returns: an array of participants with the said fullname, or nil.
    static func search(forFullname fullname: String, forTravel travel: Travel)->Participant?{
        guard let parts = travel.contient?.allObjects as? [Participant] else {return nil}
        for part in parts{
            if part.fullname == fullname{
                return part
            }
        }
        return nil
    }
    
    /**
     Searches for the participants with a exit date set as nil.
     When the exit date is something else than nil, the participant is gone from the travel.
     - Parameter travel: The travel to search the participants in.
     - Returns: an array of participants, or nil.
    */
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
