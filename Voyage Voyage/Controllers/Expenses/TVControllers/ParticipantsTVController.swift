//
//  ParticipantsTVController.swift
//  Voyage Voyage
//
//  Created by DSI on 31/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ParticipantsTVController: NSObject, UITableViewDataSource, UITableViewDelegate {
  
    

    var tableView: UITableView
    var baseView: ExpencePartBase2ViewController
    var participants: [Participant]?
    
    init(tableView: UITableView, baseView: ExpencePartBase2ViewController, participants:[Participant]?){
        self.tableView = tableView
        self.baseView = baseView
        self.participants = participants
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "participantCell", for: indexPath) as? ExpenseParticipantTVCell
       
        else {fatalError("The dequeued cell is not an instance of participantTVCell")}
        cell.memberName.text = participants![indexPath.row].fullname
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return participants?.count ?? 0
    }
    
    func haveParticipantsSelected()-> [Participant]?{
        let cells = self.tableView.visibleCells as? [PayerTVCell]
        var parts: [Participant]? = []
        for cell in cells! {
            if cell.isPayer.isOn{
                guard let indexPath = self.tableView.indexPath(for: cell) else{continue}
                parts?.append(participants![indexPath.row])
            }
        }
        return parts
    }

   
}
