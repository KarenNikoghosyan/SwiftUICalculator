//
//  Double+Extensions.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 07/09/2022.
//

import Foundation

extension Double {
    var formatter: String {
        let formatter = NumberFormatter()

        //Set it up to always display 2 decimal places.
        formatter.alwaysShowsDecimalSeparator = false
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        if let formatted = formatter.string(from: NSNumber(value: self)) {
            return formatted
        }
        return ""
    }
}

