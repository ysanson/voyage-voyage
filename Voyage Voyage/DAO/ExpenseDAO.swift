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
    
    ///Searches for all the payers of an expense.
    ///- Parameter expense: the expense to search in.
    ///- Returns: an array of participants, the ones who paid for the expense.
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
    
    ///Searches for all the participants of an expense.
    ///These are the ones that are not payers, and needs to refund.
    ///- Parameter expense: the expense to refer to.
    ///- Returns: an array of participants, or nil.
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
    
    /**
     Gets the total amount paid by the payers.
     - Parameters:
     - expense: the expense to search in.
     - payer: the payer to calculate the amount for.
     - Returns: a float, the amount the payers has paid for this expense.
    */
    static func getPaidAmount(forExpense expense:Expense, forPayer payer: Participant)->Float?{
        let parts = expense.contains?.allObjects as? [ExpensePart]
        for part in parts!{
            if part.paidBy == payer{
                return part.paidAmount
            }
        }
        return nil
    }
    
    /**
     Gets the partial amount of a participant for a specific expense.
     - Parameters:
     - expense: the expense to refer to.
     - participant: the participant to search for.
     - Returns: a float, the amount the participant has to pay.
    */
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
