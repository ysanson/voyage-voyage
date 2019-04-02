//
//  TravelExpencesViewController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class TravelExpensesViewController: UIViewController {
    
    @IBOutlet weak var navitem: UINavigationItem!
    var tbc: TravelDetailsTabBarController!
    var tableViewController: ExpensesTVController?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tbc = self.tabBarController as? TravelDetailsTabBarController
        tableViewController = ExpensesTVController(tableView: self.tableView, viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = self.navitem.title
        self.tabBarController?.navigationItem.rightBarButtonItems = self.navitem.rightBarButtonItems
    }
   
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let dest = segue.destination as? AddExpenseViewController{
            dest.travel = self.tbc.travel
        }
        else if let dest = segue.destination as? ExpenseDetailsViewController{
            if let cell = sender as? ExpenseTVCell{
                guard let indexPath = self.tableView.indexPath(for: cell) else{return}
                dest.expense = tableViewController?.expensesVM.get(expenseAt: indexPath.row)
            }
        }
    }
    

}
