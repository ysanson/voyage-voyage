//
//  VoyageTableViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 18/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class TravelTVController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView
    var travelVM : TravelVM
    var fetchedResultController: TravelFetchResultController
    var viewController: ViewController
    
    init(tableView: UITableView, viewController: ViewController){
        self.tableView = tableView
        self.viewController = viewController
        self.fetchedResultController = TravelFetchResultController(view: tableView)
        self.travelVM = TravelVM(data: self.fetchedResultController.travelsFetched)
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TravelCell", for: indexPath) as? TravelTVCell else{fatalError("The dequeued cell is not an instance of TravelTVCell.")}
        let travel = travelVM.get(travelAt: indexPath.row)
        cell.title.text = travel?.name
        cell.icon.image = travel?.picture
        return cell
        
    }
    
    //MARK- UITableViewDelegate
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .destructive, title: "Edit"){ (action, view, handler) in
            self.viewController.performSegue(withIdentifier: "editTravelFromTravels", sender: tableView.cellForRow(at: indexPath))
        }
        editAction.backgroundColor = #colorLiteral(red: 0.3724241709, green: 0.06135788213, blue: 0.9991285863, alpha: 1)
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, handler) in
            self.deletePrompt(travel: (self.travelVM.get(travelAt: indexPath.row))!)
        }
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return config
    }
    
    func deletePrompt(travel: Travel){
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: { (action) -> Void in
            TravelDAO.delete(travel: travel)
            self.tableView.reloadData()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            return
        }
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        // Present dialog message to user
        viewController.present(dialogMessage, animated: true, completion: nil)
    }
}
