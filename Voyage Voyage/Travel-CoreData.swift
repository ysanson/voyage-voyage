//
//  Voyage.swift
//  Voyage Voyage
//
//  Created by DSI on 18/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import UIKit

extension Travel {
    public var name: String {return self.travelName ?? "Pas de nom"}
    public var picture: UIImage {return UIImage(data: self.travelPhoto!) ?? UIImage(named: "Default")! }
    public var date: Date? {
        get{return self.creationDate}
        set{self.creationDate = newValue}
    }
    
    convenience init(travelName: String, travelImage: UIImage, creationDate: Date){
        self.init(context: CoreDataManager.context)
        self.travelName = travelName
        self.travelPhoto = travelImage.jpegData(compressionQuality: 0.8)
        self.creationDate = creationDate
    }
    
    convenience init(travelName: String, creationDate: Date){
        self.init(context: CoreDataManager.context)
        self.travelName = travelName
        self.travelPhoto = UIImage(named: "Default")?.jpegData(compressionQuality: 0.8)
        self.creationDate = creationDate
    }
    
}
