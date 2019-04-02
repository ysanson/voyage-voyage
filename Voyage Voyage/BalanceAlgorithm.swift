//
//  BalanceAlgorithm.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 02/04/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation


class BalanceAlgorithm {
    
    static func calculateBalance(forParticipants participants:[Participant], withExpenses expenses: [Expense])->[Participant:Float]{
        var result: [Participant:Float] = [:]
        
        for participant in participants{
            result[participant] = 0.0
        }
        
        for exp in expenses{
            let expenseParts = ExpenseDAO.getExpenseParts(forExpense: exp)
            var concernedMembers = ExpenseDAO.fetchAllParticipants(forExpense: exp)?.count ?? 0
            concernedMembers += ExpenseDAO.fetchAllPayers(forExpense: exp)?.count ?? 0
            for part in expenseParts!{
                let newScore = (result[part.refundedBy!] ?? 0) + exp.amount/Float(concernedMembers)
                result[part.refundedBy!] = -newScore
            }
        }
        return result
    }
}
