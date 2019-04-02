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
    var expensesVM: ExpensesVM
    var expenseFetchResult: ExpenseFetchResultController
    
    init(tableView: UITableView, viewController: TravelExpensesViewController){
        self.tableView = tableView
        self.viewController = viewController
        expenseFetchResult = ExpenseFetchResultController(view: self.tableView, travel: self.viewController.tbc.travel!)
        expensesVM = ExpensesVM(data: expenseFetchResult.expensesFetched)
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expensesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as? ExpenseTVCell else{fatalError("The dequeued cell is not an instance of ExpenseTVCell.")}
        let expense = expensesVM.get(expenseAt: indexPath.row)!
        cell.expenseView.image = expense.getphoto
        cell.expenseName.text = expense.name
        cell.expenseAmount.text = "Amount paid: " + String(expense.amount)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, handler) in
            self.deleteConfirmation(expense: self.expensesVM.get(expenseAt: indexPath.row)!)
            }
            
            let config = UISwipeActionsConfiguration(actions: [deleteAction])
            return config
    }

    func deleteConfirmation(expense: Expense){
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this expense? This is irreversible.", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            ExpenseDAO.delete(expense: expense)
            self.tableView.reloadData()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            return
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        viewController.present(dialogMessage, animated: true, completion: nil)
    }
}
