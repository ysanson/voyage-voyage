//
//  ExpensePartBase3ViewController.swift
//  Voyage Voyage
//
//  Created by DSI on 30/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ExpensePartBase3ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tvc: ParticipantAmountTVController?
    var addMode: ExpensePart3ViewController?
    var travel: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tvc = ParticipantAmountTVController(vc: self, tableView: self.tableView, expense: addMode!.expense!, payers: addMode!.payers, participants: addMode?.participants!)
    }
    

}
