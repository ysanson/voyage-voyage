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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    @IBAction func unwindToTravelDetails(sender: UIStoryboardSegue){
        
    }
}
