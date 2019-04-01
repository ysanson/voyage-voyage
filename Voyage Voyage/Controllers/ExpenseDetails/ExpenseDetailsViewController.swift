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
    var payers: ExpensePayersTVController!
    var participants: ExpenseParticipantTVController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}
