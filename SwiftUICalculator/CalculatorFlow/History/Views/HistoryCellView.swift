//
//  HistoryCellView.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 05/09/2022.
//

import SwiftUI

struct HistoryCellView: View {
    
    var inputText: String
    var calculatedText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(inputText)
                .padding([.leading, .trailing], 16)
                .padding(.top, 8)
                .font(.custom("Futura", size: 18))
            
            Text(calculatedText)
                .padding(.top, 16)
                .padding(.bottom, 8)
                .padding([.leading, .trailing], 16)
                .font(.custom("Futura-Bold", size: 24))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color.init(red: 0, green: 0, blue: 0, opacity: 0.18), radius: 10, x: 0, y: 2)
        .padding([.trailing, .leading], 6)
    }
}

struct HistoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCellView(inputText: "Example", calculatedText: "Example")
    }
}
