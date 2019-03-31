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
    var travel: Travel?
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func isExpenseFullyPaid(withAmounts amounts: [Float])->Bool{
        var fullAmt: Float = 0.0
        for amt in amounts{
            fullAmt += amt
        }
        if fullAmt != expense?.amount{
            let dialogMessage = UIAlertController(title: "Error", message: "The overall amount is not equal to the expense amount", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            { (action) -> Void in
                return
            }
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            return false
        }
        return true
        
        
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
        if let dest = segue.destination as? ExpensePart2ViewController {
            let paidAmount = self.baseView?.tvc.havePayAmount()
            if self.isExpenseFullyPaid(withAmounts: paidAmount!){
                dest.payers = self.payers
                dest.expense = self.expense
                dest.payAmount = paidAmount
                dest.travel = self.travel
            }
        }
    }
}
