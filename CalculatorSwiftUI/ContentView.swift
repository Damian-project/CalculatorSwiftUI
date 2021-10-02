//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Damian B on 01/10/2021.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case substract = "-"
    case multiply = "x"
    case devide = "/"
    case equal = "="
    case clear = "AC"
    case decimal = ","
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor: Color {
        switch self {
        case .devide, .multiply, .substract, .add, .equal:
            return .orange
        case .clear, .negative, .percent:
            return .gray
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, substract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .devide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .substract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack{
                //MARK:- result text
                Spacer()
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                }
                .padding()
                
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { item in
                                Button(action: {
                                    self.didTap(button: item)
                                }, label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 42))
                                        .frame(
                                            width: self.buttonWidth(item: item),
                                            height: self.buttonHeight())
                                        .background(item.buttonColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(buttonHeight() / 2 )
                                })
                            }
                        }
                        .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .substract, .multiply, .devide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .substract {
                self.currentOperation = .substract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .devide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentNumber = Int(self.value) ?? 0
                switch currentOperation {
                case .add: self.value = "\(runningValue + currentNumber)"
                case .substract: self.value = "\(runningValue - currentNumber)"
                case .multiply: self.value = "\(runningValue * currentNumber)"
                case .divide: self.value = "\(runningValue / currentNumber)"
                case .none: break
                }
            }
            
            if button != .equal {
                value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4 ) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
