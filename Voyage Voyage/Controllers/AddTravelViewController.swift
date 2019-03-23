//
//  AddTravelViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 20/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class AddTravelViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    var travel: Travel?
    var imagePicker = UIImagePickerController()
    var image: UIImage?
    
    @IBOutlet weak var travelName: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var choosePictureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
        updateSaveButtonState()
        self.travelName.delegate = self
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
            self.image = pickedImage
            changeImageButtonState()
            updateSaveButtonState()
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func changeImageButtonState(){
        if choosePictureButton.titleLabel?.text == "Choose a picture" {
            choosePictureButton.titleLabel?.text = "Change picture"
        }
        else{
            choosePictureButton.titleLabel?.text = "Choose a picture"
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneAddTravel"{
            travel = Travel(travelName: travelName.text!, travelImage: image!, creationDate: Date.init())
            do{
                try CoreDataManager.context.save()
            }catch{fatalError()}
            if let destination = segue.destination as? AddMemberViewController{
                destination.travel = self.travel
            }
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
        doneButton.isEnabled = false
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let nameText = travelName.text ?? ""
        doneButton.isEnabled = !nameText.isEmpty && !(image == nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    

}
