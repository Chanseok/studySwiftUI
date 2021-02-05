//
//  ContentView.swift
//  WeSplit
//
//  Created by 임찬석 on 2021/02/04.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage  = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) of people")
                        }
                    }
                }
                Section{
                    Text("$" + checkAmount)
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

// Memo: What I learned
//
// 1. Simulator에서 맥 키보드 대신에 Device의 키보드를 보이게하기 (⇧⌘K) I/O > Keyboard > Connect Hardware Keyboard를 Uncheck
// 2. Picker를 NavigationView로 감싸니 그제서야 동작을 하는군요
