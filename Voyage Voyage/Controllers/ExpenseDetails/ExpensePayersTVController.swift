//
//  ExpensePayersTVController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 01/04/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import UIKit

class ExpensePayersTVController: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var tableView: UITableView!
    var payers: [Participant]?
    var expense: Expense
    
    init(tableView: UITableView, expense: Expense){
        self.tableView = tableView
        self.expense = expense
        payers = ExpenseDAO.fetchAllPayers(forExpense: expense)
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpensePayers")
        let participant = payers![indexPath.row]
        cell?.textLabel?.text = participant.fullname
        let paidAmount = ExpenseDAO.getPaidAmount(forExpense: self.expense, forPayer: participant)!
        cell?.detailTextLabel?.text = "Paid " + String(paidAmount)
        return cell!
    }
    
    
}
