//
//  ExpensesPartPayerViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 29/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ExpensesPartPayerViewController: UIViewController {

    var payers:[Participant]?
    var expense: Expense?
    var baseView: ExpensesPartBaseViewController?
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "partExpenseBase"{
            let dest = segue.destination as? ExpensesPartBaseViewController
            dest?.expense = self.expense
            dest?.addMode = self
            dest?.payers = self.payers
            baseView = dest
        }
       /* if let dest = segue.destination as? ExpensePart2ViewController {
            dest.payers = self.payers
            dest.expense = self.expense
        }*/
        
    }
    

}
