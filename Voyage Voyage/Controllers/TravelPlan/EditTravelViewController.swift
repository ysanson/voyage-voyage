//
//  EditTravelViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 26/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class EditTravelViewController: UIViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var travel: Travel?
    var travelPlanBase: TravelPlanBaseViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? TravelPlanBaseViewController{
            travelPlanBase = dest
            dest.name = (self.travel?.travelName)!
            dest.image = self.travel?.picture
            dest.editMode = self
        }
        else if segue.identifier == "doneEditTravel"{
            TravelDAO.update(travel: travel!, newName: (travelPlanBase?.travelName.text)!, newImage: (travelPlanBase?.imageView.image)!)
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

}
