//
//  CalculatorView.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 12/06/2022.
//

import SwiftUI

struct CalculatorView: View {
    
    @StateObject private var calculatorViewModel = CalculatorViewModel()
    
    @State private var isOn = false
    
    var body: some View {
        NavigationView {
            ZStack {
                isOn ? Color.init(UIColor(red: 42 / 255, green: 42 / 255, blue: 42 / 255, alpha: 1)).ignoresSafeArea() : Color.white.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Text(calculatorViewModel.inputText)
                        .font(.custom("Future", size: 20))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(height: 10)
                        .padding(.top, 14)
                        .padding(.trailing, 24)
                        .foregroundColor(isOn ? Color.white : Color.black)
                    
                    Text(calculatorViewModel.calculatedText)
                        .font(.custom("Futura-Bold", size: 32))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(height: 42)
                        .padding(.top, 8)
                        .padding([.trailing, .bottom], 24)
                        .foregroundColor(isOn ? Color.white : Color.black)
                    
                    Rectangle()
                        .fill(.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .padding([.leading, .trailing], 24)
                    
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                        ForEach(calculatorViewModel.buttonsTextArray[0..<calculatorViewModel.buttonsTextArray.count].indices, id: \.self) { index in
                            CalculatorButtonView(calculatorViewModel: calculatorViewModel, mathematicalSymbol: calculatorViewModel.buttonsTextArray[index].2, char: calculatorViewModel.buttonsTextArray[index].0, buttonImage: calculatorViewModel.buttonsTextArray[index].1 ,buttonWidth: 75, buttonHeight: 75)
                                .padding(.all, 12)
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image(systemName: "candybarphone")
                                .foregroundColor(isOn ? Color.white : Color.black)
                            
                            Text("Calculator")
                                .font(.headline)
                                .foregroundColor(isOn ? Color.white : Color.black)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            CalculatorHistoryView()
                        } label: {
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(isOn ? Color.white : Color.black)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Toggle(isOn: $isOn) {
                            Text(isOn ? "LIGHT" : "DARK")
                                .font(.custom("Futura-Bold", size: 15))
                                .foregroundColor(isOn ? Color.white : Color.black)
                        }
                        .toggleStyle(.switch)
                    }
                }
            }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
