//
//  CalculatorViewModel.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 12/06/2022.
//

import Foundation

enum MathematicalSymbol: String {
    case parentheses
    case equality
    case delete
    case clear
}

class CalculatorViewModel: ObservableObject {
    
    @Published var inputText = ""
    @Published var calculatedText = "0.0"
    
    private var leftNum = ""
    private var rightNum = ""
    private var calculated = ""
    
    let buttonsTextArray: [(String, String?, MathematicalSymbol?)] = [("C", nil, .clear), ("()", nil, .parentheses), ("delete.left.fill", "delete.left.fill", .delete), ("/", nil, nil), ("7", nil, nil), ("8", nil, nil), ("9", nil, nil), ("*", nil, nil), ("4", nil, nil), ("5", nil, nil), ("6", nil, nil), ("-", nil, nil), ("1", nil, nil), ("2", nil, nil), ("3", nil, nil), ("+", nil, nil), ("0", nil, nil), (".", nil, nil), ("=", nil, .equality)]
    
    private let mathematicalSymbols = ["*", "/", "+", "-"]
}

//MARK: - Functions
extension CalculatorViewModel {
    
    func charTapped(char: String) {
        if inputText == "" && char != "-" {
            if isContainingSymbol(char: char) {return}
        }
        
        if isContainingSymbol(char: char) {
            if inputText.last == "*" || inputText.last == "/" || inputText.last == "+" || inputText.last == "-" || inputText.last == "." { return }
        }
        
        inputText += char
    }
    
    private func isContainingSymbol(char: String) -> Bool {
        return char == "*" || char == "/" || char == "+" || char == "-" || char == "."
    }
    
    func deleteCharTapped() {
        if inputText == "" {return}
        
        inputText.remove(at: inputText.index(before: inputText.endIndex))
    }
    
    func equalTapped() {
        if inputText == "" {return}
        
        calculate()
        resetNums()
    }
    
    private func calculate() {
        if !inputText.contains("*") && !inputText.contains("/") && !inputText.contains("+") && !inputText.contains("-")  {return}
        
        for (index, letter) in inputText.enumerated() {
            
            if inputText.contains("*") || inputText.contains("/") {
                if letter == "*" || letter == "/" {
                    
                    //Searches the left side of the mathematical symbol
                    getLeftNum(index: index)
                    
                    //Searches the right side of the mathematical symbol
                    getRightNum(index: index)
                    
                    operate(mathematicalOperator: inputText[index])
                    
                    inputText = inputText.replacingOccurrences(of: "\(leftNum)\(letter)\(rightNum)", with: calculated)
                    resetNums()
                    
                    calculate()
                }
                
                continue
            }
            
            if (inputText.contains("+") || inputText.contains("-")) && !inputText[0].contains("-") {
                if letter == "+" || letter == "-" {
                    
                    //Searches the left side of the mathematical symbol
                    getLeftNum(index: index)
                    
                    //Searches the right side of the mathematical symbol
                    getRightNum(index: index)
                    
                    operate(mathematicalOperator: inputText[index])
                    
                    inputText = inputText.replacingOccurrences(of: "\(leftNum)\(letter)\(rightNum)", with: calculated)
                    resetNums()
                    
                    calculate()
                }
                
                continue
            }
        }
        
        calculatedText = calculated
        inputText = ""
    }
    
    private func getLeftNum(index: Int) {
        
        for i in (0..<index).reversed() {
            if isMathematical(index: i) {
                break
            }
            self.leftNum += inputText[i]
        }
        leftNum = String(leftNum.reversed())
    }
    
    private func getRightNum(index: Int) {
        if index > inputText.count {return}
        
        for i in index + 1..<inputText.count {
            if isMathematical(index: i) {
                break
            }
            rightNum += inputText[i]
        }
    }
    
    private func isMathematical(index: Int) -> Bool {
        return inputText[index] == "*" || inputText[index] == "/" || inputText[index] == "+" || inputText[index] == "-"
    }
    
    private func operate(mathematicalOperator: String) {
        switch mathematicalOperator {
        case "*":
            calculated = String((Double(leftNum) ?? 0.0) * (Double(rightNum) ?? 0.0))
        case "/":
            calculated = String((Double(leftNum) ?? 0.0) / (Double(rightNum) ?? 0.0))
        case "+":
            calculated = String((Double(leftNum) ?? 0.0) + (Double(rightNum) ?? 0.0))
        case "-":
            calculated = String((Double(leftNum) ?? 0.0) - (Double(rightNum) ?? 0.0))
        default:
            break
        }
    }
    
    private func resetNums() {
        leftNum = ""
        rightNum = ""
    }
    
    func clearTapped() {
        inputText = ""
        calculatedText = "0.0"
        leftNum = ""
        rightNum = ""
    }
}
