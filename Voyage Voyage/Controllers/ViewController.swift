//
//  ViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 12/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    var travelTVController: TravelTVController!
    
    @IBOutlet weak var travelTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.travelTVController = TravelTVController(tableView: travelTableView)
    }
    
    @IBAction func unwindToTravelList(sender: UIStoryboardSegue){
        //Ajout machins
    }
}

