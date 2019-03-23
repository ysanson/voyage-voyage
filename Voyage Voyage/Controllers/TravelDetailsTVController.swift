//
//  TravelDetailsTVController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class TravelDetailsTVController: NSObject, UITableViewDataSource {
    
    var tableView: UITableView
    var participantList: [Participant]?
    var travel: Travel
    var fetchedResultsController: ParticipantFetchResultController
    
    init(tableView: UITableView, travel: Travel){
        self.tableView = tableView
        self.travel = travel
        fetchedResultsController = ParticipantFetchResultController(view: tableView)
        participantList = ParticipantsDAO.search(forTravel: travel)
        super.init()
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participantList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MemberAmoutTVCell()
        let person = participantList![indexPath.row]
        cell.memberName.text = person.fullname
        let totalAmount = ParticipantsDAO.totalAmount(forParticipant: person)
        cell.memberAmount.text = String()
        if totalAmount >= 0 {
            cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        }else{
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.05588275939, blue: 0.1452993751, alpha: 0.6090448944)
        }
        return cell
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
