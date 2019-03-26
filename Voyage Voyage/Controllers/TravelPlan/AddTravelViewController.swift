//
//  AddTravelViewController.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 20/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import UIKit

class AddTravelViewController: UIViewController{

    var travel: Travel?
    var travelPlanBase: TravelPlanBaseViewController?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneAddTravel"{
            let travelName = travelPlanBase?.travelName.text!
            let travelImage = travelPlanBase?.image
            travel = Travel(travelName: travelName!, travelImage: travelImage!, creationDate: Date.init())
            do{
                try CoreDataManager.context.save()
            }catch{fatalError()}
            if let destination = segue.destination as? AddMemberViewController{
                destination.travel = self.travel
            }
        }
        else if segue.identifier == "addTravel"{
            travelPlanBase = segue.destination as? TravelPlanBaseViewController
            travelPlanBase?.addMode = self
        }
        
    }
    

}
