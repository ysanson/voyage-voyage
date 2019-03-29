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
    
    static func totalExpenses(forParticipant person: Participant) -> Float{
        return 0.0
    }
    
}
