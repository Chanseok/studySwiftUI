//
//  ContentView.swift
//  WeSplit
//
//  Created by 임찬석 on 2021/02/04.
//

import SwiftUI

struct ContentView: View {
    
    // github PAT으로 갱신하기 위한 dummy action
    // github PAT으로 갱신하기 위한 dummy action
    
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 1
    @State private var tipPercentage  = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal : Double {
        let tipSelected = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelected
        return orderAmount + tipValue
    }
    
    var totalPerPerson : Double {
        return grandTotal / (Double(numberOfPeople) + 2)
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
                            Text("\($0)")
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
                
                Section(header: Text("Amount per person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                .textCase(.none)
                
                Section(header: Text("Total amount incl. tip")){
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
                .textCase(.none)
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
// 4. Simulator에서 Keyboard가 나오지 않는 문제가 있는데 이는 Simulator가 맥의 키보드와 동일한 키보드를 찾는 과정에서 생기는 오류로서 ⇧⌘K를 이용해서 toggling하야 해결
