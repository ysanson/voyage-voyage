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
    @IBOutlet weak var navItem: UINavigationItem!
    
    var tbc: TravelDetailsTabBarController!
    
    var travelDetailsC: TravelDetailsTVController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbc = self.tabBarController as? TravelDetailsTabBarController
        travelDetailsC = TravelDetailsTVController(tableView: tableViewMember, viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = self.navItem.title
        self.tabBarController?.navigationItem.rightBarButtonItems = navItem.rightBarButtonItems
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let dest = segue.destination as? AddExpenseViewController{
            dest.travel = tbc.travel
        }
    }
 

}
