//
//  ParticipantVM.swift
//  Voyage Voyage
//
//  Created by DSI on 23/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData

class ParticipantTravelVM{
    var participantsFetched : NSFetchedResultsController<Participant>
    init(data: NSFetchedResultsController<Participant>){
        self.participantsFetched = data
    }
    
    func get(participantAt index:Int)->Participant{
        return self.participantsFetched.object(at: IndexPath(row: index, section: 0))
    }
    
    var count:Int{
        return self.participantsFetched.fetchedObjects?.count ?? 0
    }
    
}
