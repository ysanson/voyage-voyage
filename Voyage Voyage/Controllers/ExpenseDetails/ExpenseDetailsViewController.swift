//
//  ExpenseDetailsViewController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ExpenseDetailsViewController: UIViewController {

    var expense: Expense?
    @IBOutlet weak var expenseName: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var payersTableView: UITableView!
    @IBOutlet weak var participantTableView: UITableView!
    
    
    var payers: ExpensePayersTVController!
    var participants: ExpenseParticipantTVController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.payers = ExpensePayersTVController(tableView: self.payersTableView, expense: self.expense!)
        self.participants = ExpenseParticipantTVController(tableView: participantTableView, expense: self.expense!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.expenseName.text = self.expense?.name
        let amt = self.expense?.amount
        self.amount.text = String(amt!)
    }
    

}
