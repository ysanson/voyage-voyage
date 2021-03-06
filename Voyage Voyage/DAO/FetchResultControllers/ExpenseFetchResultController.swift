//
//  ExpenseFetchResultController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 29/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ExpenseFetchResultController: NSObject, NSFetchedResultsControllerDelegate{
    let tableView  : UITableView
    let travel: Travel
    
    lazy var expensesFetched : NSFetchedResultsController<Expense> = {
        // prepare a request
        let request : NSFetchRequest<Expense> = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "concerns == %@", self.travel)
        request.sortDescriptors =
            [NSSortDescriptor(key:#keyPath(Expense.name),ascending:false)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext:
            CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.tableView.beginUpdates()
    }
    
    init(view : UITableView, travel: Travel){
        self.tableView  = view
        self.travel = travel
        super.init()
        do{
            try self.expensesFetched.performFetch()
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.tableView.endUpdates()
        CoreDataManager.save()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at
        indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.tableView.beginUpdates()
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath{
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath{
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            } default:
            break
        }
    }
}
