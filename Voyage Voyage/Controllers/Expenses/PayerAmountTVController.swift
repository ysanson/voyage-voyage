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
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
