//
//  CalculatorHistoryViewModel.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 01/09/2022.
//

import Foundation

class CalculatorHistoryViewModel: ObservableObject {
    
    @Published var histories: [History]
    
    init() {
        histories = Database.shared.fetchHistory()
    }
}
