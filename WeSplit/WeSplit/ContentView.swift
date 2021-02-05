//
//  ContentView.swift
//  WeSplit
//
//  Created by 임찬석 on 2021/02/04.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 1
    @State private var tipPercentage  = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople) + 2
        let tipSelected = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelected
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                        .onTapGesture {
                            self.hideKeyboard()
                        }
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) of people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")){
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .textCase(.none)
                
                Section{
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// extension for keyboard dismissing
// refer to https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
#if canImport(UIKit)
extension View {
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

// Memo: What I learned
//
// 1. Simulator에서 맥 키보드 대신에 Device의 키보드를 보이게하기 (⇧⌘K) I/O > Keyboard > Connect Hardware Keyboard를 Uncheck
// 2. Picker를 NavigationView로 감싸니 그제서야 동작을 하는군요
// 3. [맥 활용] Finder에서 숨김 파일 보기: ⇧⌘.
