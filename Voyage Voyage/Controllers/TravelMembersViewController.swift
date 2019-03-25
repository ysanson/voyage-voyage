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
    var travel: Travel?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        travelMemberC = MemberListTVController(tableview: tableView, travel: travel!)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destController = segue.destination as? AddMemberViewController{
            destController.travel = self.travel
        }
    }
    
    @IBAction func unwindToMemberList(sender: UIStoryboardSegue){
        
    }
    

}
