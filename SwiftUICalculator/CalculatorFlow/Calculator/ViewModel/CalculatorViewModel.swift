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
    
    @Published var isNight = UserDefaults.standard.getIsNight()
    @Published var inputText = ""
    @Published var calculatedText = "0"
        
    private var leftNum = ""
    private var rightNum = ""
    private var calculated = ""
    private var isFailed = false
    
    let buttonsTextArray: [(String, String?, MathematicalSymbol?)] = [
        ("C", nil, .clear),
        ("()", nil, .parentheses),
        ("delete.left.fill", "delete.left.fill", .delete),
        ("÷", nil, nil),
        ("7", nil, nil),
        ("8", nil, nil),
        ("9", nil, nil),
        ("x", nil, nil),
        ("4", nil, nil),
        ("5", nil, nil),
        ("6", nil, nil),
        ("-", nil, nil),
        ("1", nil, nil), 
        ("2", nil, nil),
        ("3", nil, nil),
        ("+", nil, nil),
        ("0", nil, nil),
        (".", nil, nil),
        ("=", nil, .equality)
    ]
    
    private let mathematicalSymbols = ["x", "÷", "+", "-"]
}

//MARK: - Functions
extension CalculatorViewModel {
    
    func parenthesesTapped() {
        print("Parentheses")
    }
    
    func charTapped(char: String) {
        if inputText == "" && char != "-" {
            if isContainingSymbol(char: char) {return}
        }
        
        if isContainingSymbol(char: char) {
            if inputText.last == "x" || inputText.last == "÷" || inputText.last == "+" || inputText.last == "-" || inputText.last == "." { return }
        }
        
        inputText += char
    }
    
    private func isContainingSymbol(char: String) -> Bool {
        return char == "x" || char == "÷" || char == "+" || char == "-" || char == "."
    }
    
    func deleteCharTapped() {
        if inputText == "" {return}
        
        inputText.remove(at: inputText.index(before: inputText.endIndex))
    }
    
    func equalTapped() {
        if inputText == "" {return}
        
        let history = History(context: Database.shared.context)
        history.inputText = inputText
        
        calculate()
        resetNums()
        
        history.calculatedText = calculatedText
        Database.shared.saveContext()
    }
    
    private func calculate() {
        if (!inputText.contains("x") && !inputText.contains("÷") && !inputText.contains("+") && !inputText.contains("-")) ||
            (inputText.last == "x" || inputText.last == "÷" || inputText.last == "+" || inputText.last == "-")  {return}
                
        for (index, letter) in inputText.enumerated() {
            
            if isFailed {return}
            
            if inputText.contains("x") || inputText.contains("÷") {
                if letter == "x" || letter == "÷" {
                    
                    //Searches the left side of the mathematical symbol
                    getLeftNum(index: index)
                    
                    //Searches the right side of the mathematical symbol
                    getRightNum(index: index)
                    
                    if letter == "÷" && rightNum == "0" {
                        inputText = ""
                        calculatedText = "Can't divide by 0"
                        isFailed = true
                        return
                    }
                                        
                    operate(mathematicalOperator: inputText[index])
                    replaceOccurrences(letter: String(letter))
                    
                    calculate()
                }
                continue
            }
            
            if inputText.contains("+") || inputText.contains("-") {
                if letter == "-" && index == 0 {continue}
                
                if letter == "+" || letter == "-" {
                                                                
                    //Searches the left side of the mathematical symbol
                    getLeftNum(index: index)
                        
                    //Searches the right side of the mathematical symbol
                    getRightNum(index: index)
                        
                    operate(mathematicalOperator: inputText[index])
                    replaceOccurrences(letter: String(letter))
                        
                    calculate()
                }
                continue
            }
        }
        
        calculatedText = String(Double(calculated)?.formatter ?? "")
        inputText = ""
    }
    
    private func getLeftNum(index: Int) { 
        for i in (0..<index).reversed() {
            
            if i == 0 && isMathematical(index: i) {
                leftNum += inputText[i]
                continue
            }
            
            if isMathematical(index: i) {
                break
            }
            leftNum += inputText[i]
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
        return inputText[index] == "x" || inputText[index] == "÷" || inputText[index] == "+" || inputText[index] == "-"
    }
    
    private func operate(mathematicalOperator: String) {
        switch mathematicalOperator {
        case "x":
            calculated = String(((Double(leftNum) ?? 0.0) * (Double(rightNum) ?? 0.0)).formatter)
        case "÷":
            calculated = String(((Double(leftNum) ?? 0.0) / (Double(rightNum) ?? 0.0)).formatter)
        case "+":
            calculated = String(((Double(leftNum) ?? 0.0) + (Double(rightNum) ?? 0.0)).formatter)
        case "-":
            calculated = String(((Double(leftNum) ?? 0.0) - (Double(rightNum) ?? 0.0)).formatter)
        default:
            break
        }
    }
    
    private func replaceOccurrences(letter: String) {
        inputText = inputText.replacingOccurrences(of: "\(leftNum)\(letter)\(rightNum)", with: calculated)
        resetNums()
    }
    
    private func resetNums() {
        leftNum = ""
        rightNum = ""
        isFailed = false
    }
    
    func clearTapped() {
        inputText = ""
        calculatedText = "0"
        leftNum = ""
        rightNum = ""
    }
    
    func save() {
        UserDefaults.standard.setIsNight(value: self.isNight)
    }
}
