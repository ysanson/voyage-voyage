//
//  MemberFetchResultController.swift
//  Voyage Voyage
//
//  Created by DSI on 23/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ParticipantFetchResultController: NSObject, NSFetchedResultsControllerDelegate{
    let tableView  : UITableView
    let travel: Travel
    
    lazy var participantsFetched : NSFetchedResultsController<Participant> = {
        // prepare a request
        let request : NSFetchRequest<Participant> = Participant.fetchRequest()
        request.predicate = NSPredicate(format: "participe == %@", self.travel)
        request.sortDescriptors =
            [NSSortDescriptor(key:#keyPath(Participant.lastname),ascending:false)]
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
            try self.participantsFetched.performFetch()
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
