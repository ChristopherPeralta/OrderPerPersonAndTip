//
//  ContentView.swift
//  order
//
//  Created by Christopher Peralta on 18/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numbreOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numbreOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var total: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
    
        return grandTotal
    }
    
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "PEN"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numbreOfPeople) {
                        ForEach (2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip percentage" , selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code:
                        Locale.current.currency?.identifier ?? "PEN"))
                }
                
                Section("Total amount"){
                    Text(total, format: .currency(code:
                        Locale.current.currency?.identifier ?? "PEN"))
                }
                
                
            }
            .navigationTitle("Order")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
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
