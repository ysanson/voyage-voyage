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
        self.travelTVController = TravelTVController(tableView: travelTableView, viewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? TravelDetailsTabBarController{
            if let cell = sender as? TravelTVCell{
                guard let indexPath = self.travelTableView.indexPath(for: cell) else{return}
                destController.travel = travelTVController.travelVM?.get(travelAt: indexPath.row)
            }
        }
        else if let destController = segue.destination as? EditTravelViewController{
            if let cell = sender as? TravelTVCell{
                guard let indexPath = self.travelTableView.indexPath(for: cell) else{return}
                destController.travel = travelTVController.travelVM?.get(travelAt: indexPath.row)
            }
        }
    }
    
    @IBAction func unwindToTravelList(sender: UIStoryboardSegue){
        
    }
}

