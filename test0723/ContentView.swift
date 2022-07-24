//
//  ContentView.swift
//  test0723
//
//  Created by 최민지 on 2022/07/23.
//

import SwiftUI

enum CalculatorButton: String{
    case decimal = "."
    case zero = "0", one = "1",
         two = "2", three = "3",
         four = "4", five = "5",
         six = "6", seven = "7",
         eight = "8", nine = "9"
    case equals = "=", plus = "+",
         minus = "-", multiply = "X", divide = "÷"
    case ac = "AC",
         plusMinus = "\u{00B1}",
         percent = "%"
    
    var title: String{
        switch self {
        case .decimal: return "."
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "X"
        case .plusMinus: return "+/x"
        case .percent: return "%"
        case .equals : return "="
        default:
            return "AC"
        }
    }
    
    var backgroundColor: Color{
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
}

//Env object
//you can treat this as the Global Application State
class GlobalEnvironment: ObservableObject{
    
    @Published var display = ""
    
    func receiveInput(calculatorButton: CalculatorButton){
        self.display = calculatorButton.title
    }
    
}

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    var body: some View {
        
        ZStack(alignment: .bottom){
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12){
                
                HStack{
                    Spacer()
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding() //end of HStack
                
                ForEach(buttons, id: \.self){ row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self){ button in
                            CalculatorButtonView(button: button)
                        }
                    }//end of HStack
                }
            }.padding(.bottom) //end of VStack
        }//end of ZStack
    }
}

struct CalculatorButtonView : View{
    
    var button: CalculatorButton
    
    @EnvironmentObject var env : GlobalEnvironment
    
    var body: some View{
        Button(action: {
            self.env.receiveInput(calculatorButton: button)
        }) {
            Text(button.title)
                .font(.system(size: 32))
                .frame(width: buttonWidth(button: button),
                       height: buttonHeight(button: button))
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(buttonWidth(button: button))
        }
    }
    
    private func buttonHeight(button:CalculatorButton) -> CGFloat{
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    private func buttonWidth(button:CalculatorButton) -> CGFloat{
        
        if button == .zero{
            return ((UIScreen.main.bounds.width - 5*12) / 4) * 2 + 12
        }
        
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
