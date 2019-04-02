//
//  ParticipantAmountTVCell.swift
//  Voyage Voyage
//
//  Created by DSI on 30/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class ParticipantAmountTVCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var payerTextField: UITextField!
    @IBOutlet weak var participantName: UILabel!
    
    var picker = UIPickerView()
    var payers: [Participant]?
    var participant: Participant?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return payers?.count ?? 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return payers![row].fullname
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        payerTextField.text = payers![row].fullname
    }
}
