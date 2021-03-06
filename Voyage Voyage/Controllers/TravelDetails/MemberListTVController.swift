//
//  MemberListTVController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class MemberListTVController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView
    var vc: TravelMembersViewController
    var membersFetched: ParticipantFetchResultController?
    var participantVM: ParticipantsVM
    
    init(tableview: UITableView, vc: TravelMembersViewController){
        self.tableView = tableview
        self.vc = vc
        membersFetched = ParticipantFetchResultController(view: self.tableView, travel: self.vc.tbc.travel!)
        self.participantVM = ParticipantsVM(data: membersFetched!.participantsFetched)
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participantVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "travelMemberCell", for: indexPath) as? TravelMemberTVCell else{fatalError("The dequeued cell is not an instance of TravelMemberTVCell.")}
        let participant = participantVM.get(participantAt: indexPath.row)
        cell.memberName.text = participant.fullname
        cell.memberDates.text = participant.dates
        cell.memberName.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        cell.memberDates.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        if participant.exitdate != nil{
            cell.backgroundColor = #colorLiteral(red: 0.5440851166, green: 0.5440851166, blue: 0.5440851166, alpha: 0.425368618)
            cell.isActive = false
        }
        else{
            cell.isActive = true
        }
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if let cell = tableView.cellForRow(at: indexPath) as? TravelMemberTVCell{
            if cell.isActive ?? false{
                let deleteAction = UIContextualAction(style: .destructive, title: "Delete from travel"){ (action, view, handler) in
                    self.deleteConfirmation(participant: self.participantVM.get(participantAt: indexPath.row), indexPath: indexPath)
                }
                let editAction = UIContextualAction(style: .destructive, title: "Edit"){ (action, view, handler) in
                    self.vc.performSegue(withIdentifier: "editMemberFromMembers", sender: tableView.cellForRow(at: indexPath))
                }
                editAction.backgroundColor = #colorLiteral(red: 0.3724241709, green: 0.06135788213, blue: 0.9991285863, alpha: 1)
                
                let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
                return config
            }
        }
        let noActions = UIContextualAction(style: .destructive, title: "No actions available"){ (action, view, handler) in
          
        }
        noActions.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        let noConf = UISwipeActionsConfiguration(actions: [noActions])
        noConf.performsFirstActionWithFullSwipe = false
        return noConf
    }

    func deleteConfirmation(participant: Participant, indexPath: IndexPath){
        let dialogMessage: UIAlertController
        if isDeletable(forParticipant: participant){
            dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this member? His exit date will be set for today.", preferredStyle: .alert)
            // Create OK button with action handler
            let ok = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                ParticipantsDAO.setGone(forParticipant: participant)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            })
            
            // Create Cancel button with action handlder
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                return
            }
            
            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
         }
        else{
            dialogMessage = UIAlertController(title: "Error", message: "The balance for this participant is not equal to 0", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel) { (action) -> Void in
                return
            }
            dialogMessage.addAction(ok)
        }
        vc.present(dialogMessage, animated: true, completion: nil)
    }
    
    ///Checks whether or not the balance is null for a participant.
    ///- Parameter participant: the participant to ckeck.
    ///- Returns: a boolean, true if the participant's balance is null, false otherwise.
    func isDeletable(forParticipant participant: Participant)->Bool{
        let expenses = ExpenseDAO.fetch(forTravel: self.vc.tbc.travel!)
        let participantsList = ParticipantsDAO.search(forTravel: self.vc.tbc.travel!)
        let balance = BalanceAlgorithm.calculateBalance(forParticipants: participantsList!, withExpenses: expenses!)
        return balance[participant] == 0
    }
}
