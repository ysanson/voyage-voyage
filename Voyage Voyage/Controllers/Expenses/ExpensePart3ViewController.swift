//
//  ExpensePart3ViewController.swift
//  Voyage Voyage
//
//  Created by DSI on 30/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ExpensePart3ViewController: UIViewController {
    var payers: [Participant]?
    var expense: Expense?
    var paidAmount: [Participant:Float]?
    var participants: [Participant]?
    var baseView: ExpensePartBase3ViewController?
    var travel: Travel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "baseView3AddExpense"{
            let dest = segue.destination as? ExpensePartBase3ViewController
            dest!.addMode = self
            dest!.travel = self.travel!
            self.baseView = dest
        }
        else if segue.identifier == "cancelExpensePart3"{
            let dest = segue.destination as? TravelDetailsTabBarController
            dest?.travel = self.travel
        }
        else if segue.identifier == "doneAddExpense"{
            let payerParts = self.baseView!.tvc!.getCellValues()
            let partPayerCorrespondance = self.baseView?.tvc?.getPayerForParticipant()
            for (part,payer) in partPayerCorrespondance!{
                let partialAmount = payerParts![part]
                let paid = paidAmount![payer]
                var _ = ExpensePart(partialAmount: partialAmount!, paidAmount: paid!, paidBy: payer, refundedBy: part, refersTo: self.expense!)
                ExpensePartDAO.save()
            }
        }
    }
    

}
