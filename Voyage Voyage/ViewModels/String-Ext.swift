//
//  String-Ext.swift
//  Voyage Voyage
//
//  Created by Yvan Sanson on 31/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation

extension String {
    static let numberFormatter = NumberFormatter()
    var floatValue: Float {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.floatValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.floatValue
            }
        }
        return 0
    }
}
