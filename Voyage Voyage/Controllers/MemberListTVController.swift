//
//  MemberListTVController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class MemberListTVController: NSObject, UITableViewDataSource {
    
    var tableView:UITableView
    var participantList: [Participant]?
    var travel: Travel
    var fetchResultsController: ParticipantFetchResultController
    
    init(tableview: UITableView, travel: Travel){
        self.tableView = tableview
        self.travel = travel
        fetchResultsController = ParticipantFetchResultController(view: tableView)
        participantList = ParticipantsDAO.search(forTravel: travel)
        super.init()
        self.tableView.dataSource = self 
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participantList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "travelMemberCell", for: indexPath) as? TravelMemberTVCell else{fatalError("The dequeued cell is not an instance of TravelMemberTVCell.")}
        cell.memberName.text = participantList?[indexPath.row].fullname
        let dates = participantList?[indexPath.row].dates
        cell.memberDates.text = dates
        cell.memberName.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        cell.memberDates.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        if (dates?.split(separator: "/").count ?? 0) > 2{
            cell.backgroundColor = #colorLiteral(red: 0.5440851166, green: 0.5440851166, blue: 0.5440851166, alpha: 0.425368618)
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
