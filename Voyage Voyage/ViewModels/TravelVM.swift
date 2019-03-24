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
//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
/// Delegate to simulate reactive programming to change of Travel set
protocol TravelVMDelegate {
    // MARK: -
    /// called when set globally changes
    func dataSetChanged()
    /// called when a Travel is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func travelDeleted(at indexPath: IndexPath)
    /// called when a Travel is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func travelUpdated(at indexPath: IndexPath)
    /// called when a Travel is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func travelAdded(at indexPath: IndexPath)
}

//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
class TravelVM{
    // MARK: -
    var delegate : TravelVMDelegate? = nil
    var travelsFetched : NSFetchedResultsController<Travel>
    init(data: NSFetchedResultsController<Travel>){
        self.travelsFetched = data
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    /// add a new Travel in set of Travels
    ///
    /// - Parameter Travel: Travel to be added
    public func add(travel: Travel){
        if let indexPath = self.travelsFetched.indexPath(forObject: travel){
            self.delegate?.travelAdded(at: indexPath)
        }
    }
    public var count : Int {
        return self.travelsFetched.fetchedObjects?.count ?? 0
    }
    
    public func get(travelAt index: Int) -> Travel?{
        return self.travelsFetched.object(at: IndexPath(row: index, section: 0))
    }
    
}
