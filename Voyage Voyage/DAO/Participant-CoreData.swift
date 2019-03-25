//
//  Participant-CoreData.swift
//  Voyage Voyage
//
//  Created by DSI on 23/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData

extension Participant{
    public var fullname: String {return (self.firstname ?? "") + " " + (self.lastname ?? "")}
    public var dates: String {
        let format = DateFormatter()
        format.dateFormat = "dd.MM.yyyy"
        let date1 = format.string(from: self.entrydate!)
        let date2: String
        if self.exitdate != nil{
            date2 = format.string(from: self.exitdate!)
        }else{
            date2 = ""
        }
        return date1 + " / " + date2
    }
    
    convenience init(firstname: String, lastname: String, entryDate: Date, travel: Travel){
        self.init(context: CoreDataManager.context)
        self.firstname = firstname
        self.lastname = lastname
        self.entrydate = entryDate
        self.exitdate = nil
        self.addToParticipe(travel)
        travel.addToContient(self)
    }
    
}
