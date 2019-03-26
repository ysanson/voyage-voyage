//
//  EditMemberViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 26/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class EditMemberViewController: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelAddButton: UIBarButtonItem!
    
    var travel: Travel?
    var participant: Participant?
    var baseView: MemberBaseViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "doneEditMember"{
            let fName = baseView?.firstnameField.text
            let lName = baseView?.lastnameField.text
            let entDate = baseView?.travelEntryDate.date
            ParticipantsDAO.update(forParticipant: participant!, newFirstName: fName!, newLastName: lName!, newEntryDate: entDate!)
            let dest = segue.destination as? TravelDetailsTabBarController
            dest?.travel = self.travel
        }
        else if segue.identifier == "cancelEditMember"{
            let dest = segue.destination as? TravelDetailsTabBarController
            dest?.travel = self.travel
        }
        else if segue.identifier == "editMemberBaseView"{
            let dest = segue.destination as? MemberBaseViewController
            dest?.editMemberController = self
            dest?.fname = participant?.firstname
            dest?.lName = participant?.lastname
            dest?.entDate = participant?.entrydate
            self.baseView = dest
        }
    }
    

}
