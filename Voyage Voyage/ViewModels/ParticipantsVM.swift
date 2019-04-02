//
//  MembersVM.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 02/04/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData

class ParticipantsVM{
    var participantsFetched: NSFetchedResultsController<Participant>
    
    init(data: NSFetchedResultsController<Participant>){
        self.participantsFetched = data
    }
    
    public var count: Int{
        return participantsFetched.fetchedObjects?.count ?? 0
    }
    
    public func get(participantAt index: Int)->Participant{
        return self.participantsFetched.object(at: IndexPath(row: index, section: 0))
    }
}
