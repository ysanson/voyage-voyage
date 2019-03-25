//
//  TravelDetailsViewController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class TravelDetailsViewController: UIViewController {

    @IBOutlet weak var tableViewMember: UITableView!
    
    var travelDetailsC: TravelDetailsTVController!
    var travel: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        travelDetailsC = TravelDetailsTVController(tableView: tableViewMember, travel: travel!)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destController = segue.destination as? TravelMembersViewController{
            destController.travel = self.travel
        }
    }
 

}
