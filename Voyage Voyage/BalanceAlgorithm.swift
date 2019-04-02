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
            for part in expenseParts!{
                result[part.refundedBy!] = (result[part.refundedBy!] ?? 0) - part.partialAmount
                result[part.paidBy!] = (result[part.paidBy!] ?? 0) + part.partialAmount
            }
        }
        return result
    }
}
