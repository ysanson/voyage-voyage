//
//  PayerAmountTVController.swift
//  Voyage Voyage
//
//  Created by DSI on 31/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class PayerAmountTVController: NSObject, UITableViewDataSource, UITableViewDelegate {
  
    var tableView: UITableView
    var baseView: ExpensesPartBaseViewController
    var payers: [Participant]?
    var expense : Expense?
    
    init(tableView: UITableView, baseView: ExpensesPartBaseViewController, expense: Expense, payers: [Participant]?){
        self.tableView = tableView
        self.baseView = baseView
        self.payers = payers
        self.expense = expense
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "amountPayerCell", for: indexPath) as? AmountPayerTableViewCell
        else {fatalError("The dequeued cell is not an instance of amountTVCell")}
        cell.payername.text = payers![indexPath.row].fullname
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return payers?.count ?? 0
    }
    
    func havePayAmount() -> [Float]?{
        let cells = self.tableView.visibleCells as? [AmountPayerTableViewCell]
        var payAmount: [Float]? = []
        for cell in cells!{
            payAmount?.append(cell.amountInput.text?.floatValue ?? 0)
        }
        return payAmount
    }

  

}
