//
//  AddExpenseViewController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController {

    var baseView: ExpenseBaseViewController?
    var travel: Travel?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addExpenseBase"{
            let dest = segue.destination as? ExpenseBaseViewController
            dest?.addMode = self
            dest?.travel = self.travel
        }
        else if segue.identifier == "nextAddExpense"{
            //TODO: save expenses
        }
    }
    

}
