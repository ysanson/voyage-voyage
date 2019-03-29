//
//  ExpencesTVController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ExpensesTVController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var viewController: TravelExpensesViewController
    var tableView: UITableView
    var expenses: [Expense]?
    
    init(tableView: UITableView, viewController: TravelExpensesViewController){
        self.tableView = tableView
        self.viewController = viewController
        super.init()
        expenses = ExpenseDAO.fetch(forTravel: viewController.tbc.travel!)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as? ExpenseTVCell else{fatalError("The dequeued cell is not an instance of ExpenseTVCell.")}
        let expense = expenses![indexPath.row]
        cell.expenseView.image = expense.getphoto
        cell.expenseName.text = expense.name
        cell.expenseAmount.text = String(expense.amount)
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
