//
//  PayerTVController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class PayerTVController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView
    var baseView: ExpenseBaseViewController
    //var fetchedResults: ParticipantFetchResultController
    var participants: [Participant]?
    
    
    init(tableView: UITableView, baseView: ExpenseBaseViewController, travel: Travel){
        self.tableView = tableView
        self.baseView = baseView
        //self.fetchedResults = ParticipantFetchResultController(view: tableView)
        self.participants = ParticipantsDAO.searchForStillHere(forTravel: travel)
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "payerCell", for: indexPath) as? PayerTVCell else{fatalError("The dequeued cell is not an instance of PayerTVCell.")}
        cell.memberName.text = participants![indexPath.row].fullname
        cell.isPayer.isOn = false
        return cell
    }
    
    ///Retrieves the payers of an expense.
    ///- Returns: an array of participants, or nil.
    func havePayer()-> [Participant]?{
        let cells = self.tableView.visibleCells as? [PayerTVCell]
        var payers: [Participant]? = []
        for cell in cells! {
            if cell.isPayer.isOn{
                guard let indexPath = self.tableView.indexPath(for: cell) else{continue}
                payers?.append(participants![indexPath.row])
            }
        }
        return payers
    }
}
