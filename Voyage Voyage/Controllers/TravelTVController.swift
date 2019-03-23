//
//  VoyageTableViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 18/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class TravelTVController: NSObject, UITableViewDataSource, TravelVMDelegate {
    
    
    
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
}
