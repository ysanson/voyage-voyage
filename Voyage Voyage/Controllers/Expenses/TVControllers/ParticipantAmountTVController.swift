//
//  ParticipantAmountTVController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 01/04/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ParticipantAmountTVController: NSObject, UITableViewDataSource, UITableViewDelegate {

    

    var viewController: ExpensePartBase3ViewController
    var tableView: UITableView
    var payers: [Participant]?
    var participants: [Participant]?
    var expense : Expense?
    
    init(vc: ExpensePartBase3ViewController, tableView: UITableView, expense: Expense, payers: [Participant]?, participants: [Participant]? ){
        self.viewController = vc
        self.tableView = tableView
        self.payers = payers
        self.expense = expense
        self.payers = payers
        self.participants = participants
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return participants?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "participantAmountTVCell", for: indexPath) as? ParticipantAmountTVCell else { fatalError() }
        cell.participant = self.participants![indexPath.row]
        cell.participantName.text = cell.participant?.fullname
        cell.payers = self.payers
        cell.picker.delegate = cell
        cell.picker.dataSource = cell
        cell.payerTextField.inputView = cell.picker
        cell.payerTextField.text = payers![0].fullname
        return cell
    }
    
    func getCellValues()->[Participant:Float]?{
        var dict: [Participant:Float] = [:]
        let cells = self.tableView.visibleCells as? [ParticipantAmountTVCell]
        for cell in cells!{
            dict[cell.participant!] = cell.amountTextField.text?.floatValue ?? 0
        }
        return dict
    }
    
    func getPayerForParticipant()->[Participant:Participant]{
        var dict: [Participant:Participant] = [:]
        let cells = self.tableView.visibleCells as? [ParticipantAmountTVCell]
        for cell in cells!{
            dict[cell.participant!] = ParticipantsDAO.search(forFullname: cell.payerTextField.text!, forTravel: self.viewController.travel!)
        }
        return dict
    }

}
