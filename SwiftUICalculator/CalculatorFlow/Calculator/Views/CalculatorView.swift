//
//  CalculatorView.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 12/06/2022.
//

import SwiftUI

struct CalculatorView: View {
    
    @StateObject private var calculatorViewModel = CalculatorViewModel()
    
    @State private var navigationTitleColor = UIColor.black
                
    var body: some View {
        NavigationView {
            ZStack {
                calculatorViewModel.isNight ? Color.init(UIColor(red: 42 / 255, green: 42 / 255, blue: 42 / 255, alpha: 1)).ignoresSafeArea() : Color.white.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Text(calculatorViewModel.inputText)
                        .font(.custom("Future", size: 20))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(height: 10)
                        .padding(.top, 14)
                        .padding(.trailing, 24)
                        .foregroundColor(calculatorViewModel.isNight ? Color.white : Color.black)
                    
                    Text(calculatorViewModel.calculatedText)
                        .font(.custom("Futura-Bold", size: 32))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(height: 42)
                        .padding(.top, 8)
                        .padding([.trailing, .bottom], 24)
                        .foregroundColor(calculatorViewModel.isNight ? Color.white : Color.black)
                    
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
                .navigationTitle("Calculator")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            CalculatorHistoryView(calculatorViewModel: calculatorViewModel)
                        } label: {
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(calculatorViewModel.isNight ? Color.white : Color.black)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Toggle(isOn: $calculatorViewModel.isNight) {
                            Text(calculatorViewModel.isNight ? "LIGHT" : "DARK")
                                .font(.custom("Futura-Bold", size: 15))
                                .foregroundColor(calculatorViewModel.isNight ? Color.white : Color.black)
                        }
                        .onChange(of: calculatorViewModel.isNight, perform: { _ in
                            changeNavigationTitleTextColor()
                            calculatorViewModel.save()
                        })
                        .toggleStyle(.switch)
                    }
                }
            }
        }
        .accentColor(calculatorViewModel.isNight ? Color.white : Color.black)
        .onAppear {
            changeNavigationTitleTextColor()
        }
        .id(navigationTitleColor)
    }
    
    private func changeNavigationTitleTextColor() {
        navigationTitleColor = calculatorViewModel.isNight ? UIColor.white : UIColor.black
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: navigationTitleColor]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: navigationTitleColor]
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
