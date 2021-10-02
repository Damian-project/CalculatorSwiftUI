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

struct ContentView: View {
    
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
                    Text("0")
                        .bold()
                        .font(.system(size: 64))
                        .foregroundColor(.white)
                }
                .padding()
                
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { item in
                                Button(action: {
                                    
                                }, label: {
                                    Text(item.rawValue)
                                        .bold()
                                        .font(.system(size: 32))
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
    
    func buttonWidth(item: CalcButton) -> CGFloat {
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
