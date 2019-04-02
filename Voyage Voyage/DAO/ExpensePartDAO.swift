//
//  ExpensePartDAO.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 29/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData

class ExpensePartDAO{
    static let request : NSFetchRequest<ExpensePart> = ExpensePart.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(expense:Expense ){
        CoreDataManager.context.delete(expense)
    }
    static func update(forPart expensePart: ExpensePart, partialAmount: Float, paidAmount: Float){
        expensePart.paidAmount = paidAmount
        expensePart.partialAmount = partialAmount
        save();
    }
    
    static func fetchAll() -> [ExpensePart]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
    static func search(forExpense expense: Expense)->[ExpensePart]?{
        return expense.contains?.allObjects as? [ExpensePart]
    }
    
    static func getPaidAmount(forExpense expense:Expense, forPayer payer: Participant)->Float?{
        let parts = expense.contains?.allObjects as? [ExpensePart]
        for part in parts!{
            if part.paidBy == payer{
                return part.paidAmount
            }
        }
        return nil
    }
    
    static func getPartialAmount(forExpense expense:Expense, forParticipant participant: Participant)->Float?{
        let parts = expense.contains?.allObjects as? [ExpensePart]
        for part in parts!{
            if part.refundedBy == participant{
                return part.partialAmount
            }
        }
        return nil
    }
    
    
}
