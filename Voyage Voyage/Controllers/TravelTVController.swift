//
//  VoyageTableViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 18/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class TravelTVController: NSObject, UITableViewDataSource, UITableViewDelegate, TravelVMDelegate {
    
    var tableView: UITableView
    var travelVM : TravelVM?
    var fetchedResultController: TravelFetchResultController
    
    init(tableView: UITableView){
        self.tableView = tableView
        self.fetchedResultController = TravelFetchResultController(view: tableView)
        self.travelVM = TravelVM(data: self.fetchedResultController.travelsFetched)
        super.init()
        self.tableView.dataSource = self
        self.travelVM?.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (travelVM?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TravelCell", for: indexPath) as? TravelTVCell else{fatalError("The dequeued cell is not an instance of TravelTVCell.")}
        let travel = travelVM?.get(travelAt: indexPath.row)
        cell.title.text = travel?.name
        cell.icon.image = travel?.picture
        return cell
        
    }
    
    //MARK- UITableViewDelegate
    /*func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let updateAction = UITableViewRowAction(style: .normal, title: "Edit", handler: {(action: UITableViewRowAction, indexPath: IndexPath)-> Void in})
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: {(action: UITableViewRowAction, indexPath: IndexPath)-> Void in
            self.deletePrompt()
        })
        return [updateAction, deleteAction]
    }*/
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert{
            
        }
        
        else if editingStyle == .delete{
            self.deletePrompt()
        }
        
    }
    
    //MARK- TravelVMDelegate
    
    func dataSetChanged() {
        self.tableView.reloadData()
    }
    
    func travelDeleted(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func travelUpdated(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func travelAdded(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func deletePrompt(){
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            //deleteRecord()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            return
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        //present(dialogMessage, animated: true, completion: nil)
    }
}
