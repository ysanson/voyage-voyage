//
//  Expense-CoreData$.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 29/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Expense{
    public var getphoto: UIImage{
        return UIImage(data: self.photo!) ?? UIImage(named: "Default")!
    }
    
    convenience init(expenseName: String, amount: Float, photo: UIImage){
        self.init(context: CoreDataManager.context)
        self.name = expenseName
        self.amount = amount
        self.photo = photo.jpegData(compressionQuality: 0.8)
    }
    
    convenience init(expenseName: String, amount: Float){
        self.init(context: CoreDataManager.context)
        self.name = expenseName
        self.amount = amount
        self.photo = UIImage(named: "Default")?.jpegData(compressionQuality: 0.8)
    }
}
