//
//  MemberBaseViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 26/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class MemberBaseViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var travelEntryDate: UIDatePicker!
    
    var addMemberController: AddMemberViewController?
    var editMemberController: EditMemberViewController?
    var fname: String?
    var lName: String?
    var entDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lastnameField.delegate = self
        self.firstnameField.delegate = self
        updateSaveButtonState()
        self.lastnameField.text = lName
        self.firstnameField.text = fname
        self.travelEntryDate.date = entDate ?? Date.init()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        if addMemberController != nil{
            addMemberController?.saveButton.isEnabled = false
        }
        else if editMemberController != nil{
            editMemberController?.saveButton.isEnabled = false
        }
        
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let firstname = firstnameField.text ?? ""
        let lastname = self.lastnameField.text ?? ""
        if addMemberController != nil{
            addMemberController?.saveButton.isEnabled = !firstname.isEmpty && !lastname.isEmpty
        }
        else if editMemberController != nil{
            editMemberController?.saveButton.isEnabled = !firstname.isEmpty && !lastname.isEmpty
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        updateSaveButtonState()
    }
}
