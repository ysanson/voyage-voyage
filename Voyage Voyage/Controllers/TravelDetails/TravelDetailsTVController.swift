//
//  TravelDetailsTVController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit
import os.log

class TravelDetailsTVController: NSObject, UITableViewDataSource {
    
    var tableView: UITableView
    var participantList: [Participant]?
    var viewController: TravelDetailsViewController
    var balance: [Participant:Float]
    
    init(tableView: UITableView, viewController: TravelDetailsViewController){
        self.tableView = tableView
        self.viewController = viewController
        participantList = ParticipantsDAO.search(forTravel: viewController.tbc.travel!)
        let expenses = ExpenseDAO.fetch(forTravel: viewController.tbc.travel!)
        balance = BalanceAlgorithm.calculateBalance(forParticipants: participantList!, withExpenses: expenses!)
        super.init()
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participantList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "memberAmountCell", for: indexPath) as? MemberAmoutTVCell else{fatalError("The dequeued cell is not an instance of MemberAmountTVCell.")}
        let person = participantList![indexPath.row]
        cell.name.text = person.fullname
        let totalAmount = balance[person]!
        cell.amount.text = String(totalAmount)
        cell.name.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.amount.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if totalAmount >= 0 {
            cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 0.5)
        }else{
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.05588275939, blue: 0.1452993751, alpha: 0.6090448944)
            
        }
        return cell
    }
}
