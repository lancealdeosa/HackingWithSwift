//
//  ContentView.swift
//  iExpense
//
//  Created by Lance Paolo Aldeosa on 12/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var isAddExpensePresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) {
                    ExpensesItemRow(item: $0)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    isAddExpensePresented = true
                }
            }
        }
        .sheet(isPresented: $isAddExpensePresented) {
            AddView(expenses: expenses)
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ExpensesItemRow: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type.title)
            }
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
    }
}

#Preview {
    ContentView()
}
