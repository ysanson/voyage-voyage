//
//  AddMemberViewController.swift
//  Voyage Voyage
//
//  Created by Marie SALELLES on 22/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {

    var travel: Travel?
    var participant: Participant?
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var travelEntryDate: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateSaveButtonState()
        lastnameField.delegate = self
        self.firstnameField.delegate = self
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneAddMember"{
            participant = Participant(firstname: firstnameField.text!, lastname: lastnameField.text!, entryDate: travelEntryDate.date, travel: travel!)
            do{
                try CoreDataManager.context.save()
            }catch{fatalError()}
            if let dest = segue.destination as? TravelMembersViewController{
                dest.tbc.travel = self.travel
            }
        }
    }
    
    @IBAction func unwindToAddMember(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? AddTravelViewController{
            travel = sourceViewController.travel
        } else if let sourceViewController = sender.source as? TravelMembersViewController{
            travel = sourceViewController.tbc.travel
        }
    }
    
    //MARK: TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text{
            if text != ""{
                textField.resignFirstResponder()
                return true
            }
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let firstname = firstnameField.text ?? ""
        let lastname = self.lastnameField.text ?? ""
        saveButton.isEnabled = !firstname.isEmpty && !lastname.isEmpty
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

}
