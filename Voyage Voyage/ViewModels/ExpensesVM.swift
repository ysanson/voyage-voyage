//
//  ExpensesVM.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 02/04/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData

class ExpensesVM{
    var expensesFetched: NSFetchedResultsController<Expense>
    
    init(data: NSFetchedResultsController<Expense>){
        self.expensesFetched = data
    }
    
    public var count: Int{
        return self.expensesFetched.fetchedObjects?.count ?? 0
    }
    
    public func get(expenseAt index: Int)->Expense?{
        return self.expensesFetched.object(at: IndexPath(row: index, section: 0))
    }
}
