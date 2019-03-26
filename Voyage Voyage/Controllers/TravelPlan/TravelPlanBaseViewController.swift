//
//  TravelPlanBaseViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 26/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class TravelPlanBaseViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var travelName: UITextField!
    @IBOutlet weak var choosePictureButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var image: UIImage?
    var addMode: AddTravelViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.travelName.delegate = self
        imagePicker.delegate = self
        updateSaveButtonState()
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
        //doneButton.isEnabled = false
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let nameText = travelName.text ?? ""
        addMode!.doneButton.isEnabled = !nameText.isEmpty && !(image == nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    

}
