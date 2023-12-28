//
//  AddView.swift
//  iExpense
//
//  Created by Lance Paolo Aldeosa on 12/28/23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var type = ExpenseItem.ExpenseType.personal
    @State private var amount = 0.0
    
    var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(ExpenseItem.ExpenseType.allCases, id: \.self) {
                        Text($0.title)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
