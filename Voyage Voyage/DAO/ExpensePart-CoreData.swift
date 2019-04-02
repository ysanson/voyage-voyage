//
//  ExpensePart.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 29/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData

extension ExpensePart{
    
    
    convenience init(partialAmount: Float, paidAmount: Float, paidBy: Participant, refundedBy: Participant, refersTo: Expense){
        self.init(context: CoreDataManager.context)
        self.partialAmount = partialAmount
        self.paidAmount = paidAmount
        self.paidBy = paidBy
        self.refundedBy = refundedBy
        self.refersTo = refersTo
        paidBy.addToPays(self)
        refundedBy.addToRefunds(self)
        self.isRefunded = false
    }
}
