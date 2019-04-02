//
//  TravelMembersViewController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class TravelMembersViewController: UIViewController {

    var travelMemberC: MemberListTVController!
    var tbc: TravelDetailsTabBarController!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       tbc = self.tabBarController as? TravelDetailsTabBarController
        travelMemberC = MemberListTVController(tableview: tableView, vc: self)
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destController = segue.destination as? AddMemberViewController{
            destController.travel = self.tbc.travel
        }
        else if let dest = segue.destination as? EditMemberViewController{
            dest.travel = self.tbc.travel
            if let cell = sender as? TravelMemberTVCell{
                guard let indexPath = self.tableView.indexPath(for: cell) else{return}
                dest.participant = self.travelMemberC.participantVM.get(participantAt: indexPath.row)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = self.tabItem.title
        self.tabBarController?.navigationItem.rightBarButtonItems = self.tabItem.rightBarButtonItems
    }

}
