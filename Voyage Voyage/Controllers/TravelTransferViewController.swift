//
//  TravelTransferViewController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class TravelTransferViewController: UIViewController {

    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = self.navItem.title
        self.tabBarController?.navigationItem.rightBarButtonItems = self.navItem.rightBarButtonItems
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
