//
//  VoyageTableViewModel.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 19/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit
import Foundation
import CoreData

/**
 Creates a View model for the travels.
 
 */
class TravelVM{
    // MARK: -
    var travelsFetched : NSFetchedResultsController<Travel>
    
    init(data: NSFetchedResultsController<Travel>){
        self.travelsFetched = data
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    
    public var count : Int {
        return self.travelsFetched.fetchedObjects?.count ?? 0
    }
    
    
    public func get(travelAt index: Int) -> Travel?{
        return self.travelsFetched.object(at: IndexPath(row: index, section: 0))
    }
    
}
