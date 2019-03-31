//
//  ExpensesPartBaseViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 29/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ExpensesPartBaseViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var addMode: ExpensesPartPayerViewController?
    var expense: Expense?
    var payers: [Participant]?
    var tvc: PayerAmountTVController!
    var tap: UITapGestureRecognizer!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tvc = PayerAmountTVController(tableView: self.tableView, baseView: self, expense: expense!, payers: self.payers)
        tap =  UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
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
