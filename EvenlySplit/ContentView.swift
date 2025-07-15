//
//  ContentView.swift
//  EvenlySplit
//
//  Created by Arman on 15/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var totalAmount: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let total = checkAmount + tipValue
        let amountPerPerson = total / peopleCount
        return amountPerPerson
    }
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople)
                    {
                        ForEach(2..<100)
                        {
                            Text("\($0)")
                        }
                    }
                }
                Section{
                    
                    Picker("Tip Percentage", selection: $tipPercentage)
                    {
                        ForEach(tipPercentages, id: \.self)
                        {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave ?")
                }
                
                Section{
                   
                    
                    Text(totalAmount, format: .currency(code: "USD"))
                }
            }
            .navigationTitle("Evenly Split")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard)
                {
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
