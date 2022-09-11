//
//  CalculatorButtonView.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 12/06/2022.
//

import SwiftUI

struct CalculatorButtonView: View {
    
    @ObservedObject var calculatorViewModel: CalculatorViewModel
    
    var mathematicalSymbol: MathematicalSymbol?
    var char: String
    var buttonImage: String?
    var buttonWidth: CGFloat
    var buttonHeight: CGFloat
    
    var body: some View {
        Button {
            switch mathematicalSymbol {
            case .parentheses:
                break
            case .equality:
                calculatorViewModel.equalTapped()
            case .delete:
                calculatorViewModel.deleteCharTapped()
            case .clear:
                calculatorViewModel.clearTapped()
            default:
                calculatorViewModel.charTapped(char: char)
            }
            
        } label: {
            if let buttonImage = buttonImage {
                Image(systemName: buttonImage)
                    .frame(width: buttonWidth, height: buttonHeight)
                    .foregroundColor(Color(red: 0/255, green: 213/255, blue: 151/255))
                    .background(Color(red: 237/255, green: 237/255, blue: 237/255))
                    .clipShape(Circle())
            } else {
                Text(char)
                    .frame(width: buttonWidth, height: buttonHeight)
                    .foregroundColor(Color(red: 127/255, green: 127/255, blue: 127/255))
                    .background(Color(red: 237/255, green: 237/255, blue: 237/255))
                    .clipShape(Circle())
            }
        }
    }
}

struct CalculatorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonView(calculatorViewModel: CalculatorViewModel(), mathematicalSymbol: nil, char: "1", buttonWidth: 75, buttonHeight: 75)
    }
}
