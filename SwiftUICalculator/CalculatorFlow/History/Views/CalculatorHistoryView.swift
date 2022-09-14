//
//  CalculatorHistoryView.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 01/09/2022.
//

import SwiftUI

struct CalculatorHistoryView: View {
    
    @StateObject var calculatorHistoryViewModel = CalculatorHistoryViewModel()
    @ObservedObject var calculatorViewModel: CalculatorViewModel
    
    var body: some View {
        ZStack {
            calculatorViewModel.isNight ? Color.init(UIColor(red: 42 / 255, green: 42 / 255, blue: 42 / 255, alpha: 1)).ignoresSafeArea() : Color.white.ignoresSafeArea()
            
            Text(calculatorHistoryViewModel.histories.isEmpty ? "NOTHING TO SEE HERE" : "")
                .font(.custom("Futura-Bold", size: 16))
                .foregroundColor(calculatorViewModel.isNight ? Color.white : Color.black)

            List {
                ForEach(calculatorHistoryViewModel.histories, id: \.self) { history in
                    HistoryCellView(calculatorViewModel: calculatorViewModel, inputText: history.inputText ?? "", calculatedText: history.calculatedText ?? "")
                        .frame(maxWidth: .infinity)
                }
                .onDelete { indexSet in
                    Database.shared.delete(history: calculatorHistoryViewModel.histories.remove(at: indexSet[indexSet.startIndex]))
                }
                .listRowSeparator(.hidden)
                .listRowBackground(calculatorViewModel.isNight ? Color.init(red: 42 / 255, green: 42 / 255, blue: 42 / 255, opacity: 1) : Color.white)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            EditButton()
        }
    }
}

struct CalculatorHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorHistoryView(calculatorViewModel: CalculatorViewModel())
    }
}
