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
    
    init(tableView: UITableView, expense: Expense){
        self.tableView = tableView
        payers = ExpenseDAO.fetchAllPayers(forExpense: expense)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
