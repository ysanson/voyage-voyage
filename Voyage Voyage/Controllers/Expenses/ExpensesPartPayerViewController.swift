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
    
    ///Calculates the amount that the current payers pays.
    ///If the amount is not equal, it generates an alert and blocks the segue.
    ///- Parameter amount: a dictionnary containing the participants and theeir payment.
    ///- Returns: boolean, true if it's equal, false otherwise.
    func isExpenseFullyPaid(withAmounts amounts: [Participant:Float])->Bool{
        var fullAmt: Float = 0.0
        for (_, value) in amounts{
            fullAmt += value
        }
        if fullAmt != expense?.amount{
            let dialogMessage = UIAlertController(title: "Error", message: "The overall amount is not equal to the expense amount (\(String(describing: expense?.amount)))", preferredStyle: .alert)
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
            let paidAmount = self.baseView?.tvc.getPayAmount()
            if self.isExpenseFullyPaid(withAmounts: paidAmount!){
                dest.payers = self.payers
                dest.expense = self.expense
                dest.paidAmount = paidAmount
                dest.travel = self.travel
            }
        }
        else if segue.identifier == "cancelAddExpense1"{
            let dest = segue.destination as? TravelDetailsTabBarController
            dest?.travel = self.travel
        }
    }
}
