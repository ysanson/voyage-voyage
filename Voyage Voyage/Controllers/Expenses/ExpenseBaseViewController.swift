//
//  ExpenseBaseViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 29/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ExpenseBaseViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate  {

    var amount: Float?
    var photo: UIImage?
    var imagePicker = UIImagePickerController()
    var addMode: AddExpenseViewController?
    var tvc: PayerTVController!
    var travel: Travel?
    
    @IBOutlet weak var expenseName: UITextField!
    @IBOutlet weak var totalAmountTextField: UITextField!
    @IBOutlet weak var membersNameTableView: UITableView!
    @IBOutlet weak var choosePictureButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tvc = PayerTVController(tableView: self.tableView, baseView: self, travel: travel!)
    }
    

    @IBAction func pickImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.photo = pickedImage
            changeImageButtonState()
            updateSaveButtonState()
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func changeImageButtonState(){
        if self.photo != nil {
            choosePictureButton.titleLabel?.text = "Change picture"
        }
        else{
            choosePictureButton.titleLabel?.text = "Choose a picture"
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
        //doneButton.isEnabled = false
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let amount = totalAmountTextField.text ?? ""
        if addMode != nil{
            addMode!.doneButton.isEnabled = !amount.isEmpty && !(self.photo == nil)
        }
        /*else if editMode != nil{
            editMode!.doneButton.isEnabled = !nameText.isEmpty && !(self.imageView.image == nil)
        }*/
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        updateSaveButtonState()
    }
}
