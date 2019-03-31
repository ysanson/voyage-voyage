//
//  ExpencePartBase2ViewController.swift
//  Voyage Voyage
//
//  Created by DSI on 30/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ExpencePartBase2ViewController:  UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var participants : [Participant]?
    var addMode: ExpensePart2ViewController?
    var tvc : ParticipantsTVController!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvc = ParticipantsTVController(tableView: self.tableView, baseView: self,participants: self.participants)
        // Do any additional setup after loading the view.
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
