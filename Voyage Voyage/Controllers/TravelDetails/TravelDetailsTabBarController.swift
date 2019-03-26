//
//  TravelDetailsTabBarController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 26/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import UIKit

class TravelDetailsTabBarController: UITabBarController{
    var travel: Travel?
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        /*if let dest = self.selectedViewController as? TravelDetailsViewController{
            dest.travel = self.travel
        }
        else if let dest = self.selectedViewController as? TravelMembersViewController{
            dest.travel = self.travel
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindToTravelDetails(sender: UIStoryboardSegue){
        
    }
}
