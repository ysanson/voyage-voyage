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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
