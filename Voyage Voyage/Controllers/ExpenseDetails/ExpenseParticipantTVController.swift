//
//  ExpenseParticipantTVController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 01/04/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import UIKit

class ExpenseParticipantTVController: NSObject, UITableViewDataSource, UITableViewDelegate{
    var tableView: UITableView!
    var participants: [Participant]?
    var expense: Expense
    
    init(tableView: UITableView, expense: Expense){
        self.tableView = tableView
        self.expense = expense
        self.participants = ExpenseDAO.fetchAllParticipants(forExpense: expense)
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseParticipants")
        let participant = participants![indexPath.row]
        cell?.textLabel?.text = participant.fullname
        let partialAmount = ExpensePartDAO.getPartialAmount(forExpense: expense, forParticipant: participant)!
        cell?.detailTextLabel?.text = "Due: " + String(partialAmount)
        return cell!
    }
    
    
    
}
