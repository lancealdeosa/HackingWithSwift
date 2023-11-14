//
//  ContentView.swift
//  WeSplit
//
//  Created by Lance Paolo Aldeosa on 9/26/23.
//

import SwiftUI

struct ContentView: View {
  @FocusState private var isAmountFocused: Bool
  
  @State private var checkAmount = 0.0
  @State private var numberOfPeopleIndex = 0
  @State private var tipPercentage = 20
  
  private let tipPercentages = [10, 15, 20, 25, 0]
  
  private var numberOfPeople: Int { numberOfPeopleIndex + 2 }
  private var tipAmount: Double { checkAmount * Double(tipPercentage) / 100 }
  private var totalAmount: Double { checkAmount + tipAmount }
  private var amountPerPerson: Double { totalAmount / Double(numberOfPeople) }
  
  private var currencyFormat: FloatingPointFormatStyle<Double>.Currency { .currency(code: Locale.current.currency?.identifier ?? "PHP") }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "PHP"))
            .keyboardType(.decimalPad)
            .focused($isAmountFocused)
          Picker("Numer of People", selection: $numberOfPeopleIndex) {
            ForEach(2..<100) {
              Text("\($0)")
            }
          }
        }
        Section("How much do you want to tip?") {
          Picker("Tip Percentage", selection: $tipPercentage) {
            ForEach(tipPercentages, id: \.self) {
              Text($0, format: .percent)
            }
          }
          .pickerStyle(.navigationLink)
        }
        Section("Total amount") {
          Text(totalAmount, format: currencyFormat)
            .foregroundStyle(tipPercentage == 0 ? .red : .primary)
        }
        Section("Amount per person") {
          Text(amountPerPerson, format: currencyFormat)
        }
      }
      .navigationTitle("WeSplit")
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          Spacer()
          Button("Done") {
            isAmountFocused.toggle()
          }
        }
      }
      //            .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
