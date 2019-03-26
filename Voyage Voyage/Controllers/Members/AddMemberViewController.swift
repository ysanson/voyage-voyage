//
//  AddMemberViewController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController{

    var travel: Travel?
    var participant: Participant?
    var baseView: MemberBaseViewController?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneAddMember"{
            let firstName = baseView?.firstnameField.text
            let lastName = baseView?.lastnameField.text
            let entryDate = baseView?.travelEntryDate.date
            
            participant = Participant(firstname: firstName!, lastname: lastName!, entryDate: entryDate!, travel: travel!)
            do{
                try CoreDataManager.context.save()
            }catch{fatalError()}
            if let dest = segue.destination as? TravelDetailsTabBarController{
                dest.travel = self.travel
            }
        }
        else if segue.identifier == "cancelAddMember"{
            if let dest = segue.destination as? TravelDetailsTabBarController{
                dest.travel = self.travel
            }
        }
        else if segue.identifier == "addMemberBaseView"{
            let dest = segue.destination as? MemberBaseViewController
            dest?.addMemberController = self
            self.baseView = dest
        }
    }
    
    @IBAction func unwindToAddMember(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? AddTravelViewController{
            travel = sourceViewController.travel
        } else if let sourceViewController = sender.source as? TravelMembersViewController{
            travel = sourceViewController.tbc.travel
        }
    }
    
    

}
