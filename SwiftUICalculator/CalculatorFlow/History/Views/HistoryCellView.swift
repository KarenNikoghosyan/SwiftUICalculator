//
//  HistoryCellView.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 05/09/2022.
//

import SwiftUI

struct HistoryCellView: View {
    
    @ObservedObject var calculatorViewModel: CalculatorViewModel
    
    var inputText: String
    var calculatedText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(inputText)
                .padding([.leading, .trailing], 16)
                .padding(.top, 8)
                .foregroundColor(calculatorViewModel.isNight ? Color.white : Color.black)
                .font(.custom("Futura", size: 18))
            
            Text(calculatedText)
                .padding(.top, 16)
                .padding(.bottom, 8)
                .padding([.leading, .trailing], 16)
                .foregroundColor(calculatorViewModel.isNight ? Color.white : Color.black)
                .font(.custom("Futura-Bold", size: 24))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(calculatorViewModel.isNight ? Color.init(UIColor(red: 70 / 255, green: 70 / 255, blue: 70 / 255, alpha: 1)) : Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color.init(red: 0, green: 0, blue: 0, opacity: 0.18), radius: 10, x: 0, y: 2)
        .padding([.trailing, .leading], 6)
    }
}

struct HistoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCellView(calculatorViewModel: CalculatorViewModel(), inputText: "Example", calculatedText: "Example")
    }
}
