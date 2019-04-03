//
//  ExpensePart2ViewController.swift
//  Voyage Voyage
//
//  Created by DSI on 30/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ExpensePart2ViewController: UIViewController {
    
    var payers: [Participant]?
    var expense: Expense?
    var paidAmount: [Participant:Float]?
    var baseView: ExpencePartBase2ViewController?
    var travel: Travel?

    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    ///Retrieves the participants of a travel, minus the ones who paid for the expense.
    ///- Parameter payers: array of participants who paid for the current expense.
    ///- Returns: an array of participants, who can be selected to refund the expense.
    func haveParticipants(payers: [Participant])-> [Participant]?{
        let parts = ParticipantsDAO.searchForStillHere(forTravel: self.travel!)
        var participants:[Participant] = []
        for part in parts! {
            if !payers.contains(part){
                participants.append(part)
            }
        }
        return participants
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "expensePart2"{
            let dest = segue.destination as? ExpencePartBase2ViewController
            
            dest?.addMode = self
            baseView = dest
            dest?.participants = haveParticipants(payers: self.payers!)
        }
        if let dest = segue.destination as? ExpensePart3ViewController{
            dest.expense = self.expense
            dest.payers = payers
            dest.participants = self.baseView?.tvc.haveParticipantsSelected()
            dest.paidAmount = self.paidAmount
            dest.travel = self.travel
        }
        else if segue.identifier == "cancelAddExpense2"{
            let dest = segue.destination as? TravelDetailsTabBarController
            dest?.travel = self.travel
        }
    }


}
