//
//  expenseDAO.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 29/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ExpenseDAO{
    static let request : NSFetchRequest<Expense> = Expense.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(expense:Expense ){
        CoreDataManager.context.delete(expense)
    }
    static func update(expense: Expense, amout: Float, name: String, photo: UIImage ){
        expense.amount = amout;
        expense.name = name;
        expense.photo = photo.jpegData(compressionQuality: 0.8);
        save();
    }
    
    static func fetchAll() -> [Expense]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
    static func fetch(forTravel travel: Travel)->[Expense]?{
        return travel.has?.allObjects as? [Expense]
    }
    
    static func fetchAllPayers(forExpense expense:Expense)->[Participant]?{
        let parts = expense.contains?.allObjects as? [ExpensePart]
        var payers: [Participant] = []
        for part in parts!{
            let payer = part.paidBy
            if !payers.contains(payer!){
                payers.append(payer!)
            }
        }
        return payers
    }
    
    static func fetchAllParticipants(forExpense expense: Expense)->[Participant]?{
        let parts = expense.contains?.allObjects as? [ExpensePart]
        var participants: [Participant] = []
        for part in parts!{
            let participant = part.refundedBy
            if !participants.contains(participant!){
                participants.append(participant!)
            }
        }
        return participants
    }
    
    static func getExpenseParts(forExpense expense: Expense)->[ExpensePart]?{
        return expense.contains?.allObjects as? [ExpensePart]
    }
    
}
